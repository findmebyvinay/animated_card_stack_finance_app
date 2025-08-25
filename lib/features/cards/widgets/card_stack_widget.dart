import 'package:animated_card_stack_finance/core/constants/colors.dart';
import 'package:animated_card_stack_finance/core/services/get_it/service_locator.dart';
import 'package:animated_card_stack_finance/core/widgets/loader_widget.dart';
import 'package:animated_card_stack_finance/core/widgets/widget_extension.dart';
import 'package:animated_card_stack_finance/features/cards/bloc/cards_bloc.dart';
import 'package:animated_card_stack_finance/features/cards/bloc/cards_event.dart';
import 'package:animated_card_stack_finance/features/cards/domain/models/credit_card.dart';
import 'package:animated_card_stack_finance/features/cards/widgets/animated_card.dart';
import 'package:animated_card_stack_finance/features/cards/widgets/transaction_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          child:_pageController!=null ? PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex= index;
              });
              getIt<CardsBloc>().add(SelectCardEvent(cardId:widget.cards[index].id));
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
                      getIt<CardsBloc>().add(FlipCardEvent(card.id));
                    },
                    child:AnimatedCard(card: card, isFlipped: isFlipped) ,
                    ).padHorizontal(horizontal: 8.w),
                  ), 
                  );

                } 
                );
            }):LoaderWidget(),
        ),
        20.verticalSpace,

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            widget.cards.length,
             (index)=> AnimatedContainer(
              duration:const Duration(milliseconds: 300),
              width: _currentIndex== index ? 24.w:8.w,
              height: 8.h,
              decoration: BoxDecoration(
                color: _currentIndex== index?AppColors.whiteColor:AppColors.whiteColor.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(4),
              ),
              )),
        ),
        30.verticalSpace,
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