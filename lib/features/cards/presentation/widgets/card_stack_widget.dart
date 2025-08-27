import 'dart:developer';

import 'package:animated_card_stack_finance/core/constants/colors.dart';
import 'package:animated_card_stack_finance/core/widgets/loader_widget.dart';
import 'package:animated_card_stack_finance/core/widgets/widget_extension.dart';
import 'package:animated_card_stack_finance/features/cards/bloc/cards_bloc.dart';
import 'package:animated_card_stack_finance/features/cards/bloc/cards_event.dart';
import 'package:animated_card_stack_finance/features/cards/domain/models/credit_card.dart';
import 'package:animated_card_stack_finance/features/cards/presentation/widgets/animated_card.dart';
import 'package:animated_card_stack_finance/features/cards/presentation/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardStackWidget extends StatefulWidget {
  final List<CreditCard> cards;
  final String? selectedCardId;
  final Set<String> flippedCards;

  const CardStackWidget({
    super.key,
    required this.cards,
    this.selectedCardId,
    required this.flippedCards,
  });

  @override
  State<CardStackWidget> createState() => _CardStackWidgetState();
}

class _CardStackWidgetState extends State<CardStackWidget> with TickerProviderStateMixin{
  
   PageController? _pageController;
  int _currentIndex=0;

  @override
  void initState() {
    super.initState();
    _pageController= PageController(viewportFraction: 0.8);
  }
  @override
  void dispose() {
    _pageController?.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 300,
          width: double.infinity,
          child:_pageController!=null ? PageView.builder(
            scrollDirection: Axis.vertical,
            physics:const AlwaysScrollableScrollPhysics(),
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex= index;
              });
              context.read<CardsBloc>().add(SelectCardEvent(cardId:widget.cards[index].id));
            },
            itemCount: widget.cards.length,
            itemBuilder: (context,index){
              final card= widget.cards[index];
              final isFlipped= widget.flippedCards.contains(card.id);
              return AnimatedBuilder(
                animation: _pageController!, 
                builder:(context,child){
                double value=0;

                if(_pageController!.position.haveDimensions){
                value= index-(_pageController?.page ?? 0);
                value= (value* 0.038).clamp(-1, 1);
                }

                return Transform.translate(
                  offset:Offset(value*200, 0),
                  child: Transform.scale(
                    scale: 1-(value.abs()*0.1),
                    child: GestureDetector(
                    onTap: (){
                      log('card is added');
                      context.read<CardsBloc>().add(FlipCardEvent(card.id));
                    },
                    child:AnimatedCard(card: card, isFlipped: isFlipped) ,
                    ).padHorizontal(horizontal: 8),
                  ), 
                  );

                } 
                );
            }):LoaderWidget(),
        ),
        const SizedBox(height:20),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.cards.length,
             (index)=> AnimatedContainer(
              duration:const Duration(milliseconds: 300),
              width: _currentIndex== index ? 24:8,
              height: 8,
              decoration: BoxDecoration(
                color: _currentIndex== index?AppColors.whiteColor:AppColors.whiteColor.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4),
              ),
              )),
        ),
        const SizedBox(height:30),
        if(widget.selectedCardId==null) Text('No Recent Transaction Yet',
        style: TextStyle(
          color: AppColors.whiteColor,
          fontSize: 24
        ),
        ),
       
         if (widget.selectedCardId != null) ...[
          Expanded(
            child: TransactionList(
              card: widget.cards.firstWhere(
                (card) => card.id == widget.selectedCardId,
                orElse: ()=> widget.cards.first,
              ),
            ),
          ),
        ],
      ],
    );
  }
}