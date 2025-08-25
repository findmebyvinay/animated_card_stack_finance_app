class DartFormatter {
  static String formatTransactionDate(DateTime date){
    final now= DateTime.now();
    final difference= now.difference(now);

    if(difference.inDays ==0){
      return 'Today';
    }
    else if(difference.inDays==1){
      return 'Yesterday';
    }
    else{
      return '${difference.inDays} days ago';
    }
  }
}