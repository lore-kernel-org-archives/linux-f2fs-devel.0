Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA79BD3EE63
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Jan 2026 13:45:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SRy/8UDoIPYll2gZlaXEWI+MLtDOsCLGCr5PLAPfWZM=; b=R7M+TtW2oflBZDgU/qxEnHJXoB
	gToNVTOPFwz9au/oSdsmlVfsGY1d58YXP0DnH0v2px9A+Fzo3xe6zZSLi384OnOjGfd4+I89e56V9
	Tev9MGvGnXuFF+CVWJ7IboUQLG4I1Uy0Eie2/4Mqcm80Z663y6OmW3k7U1UU57prxdaY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1viv03-0001aD-UI;
	Thu, 22 Jan 2026 13:45:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sajiv@icompucare.my>) id 1viv02-0001a7-7I
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Jan 2026 13:45:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:Date:Subject:To:From:Reply-To:Sender:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YcC18MwU7reQdlDJEAzOSvGKZE6b154t0b5VERSvP7Q=; b=T/msfjBYBXjb5w1WjpHHFnZMx2
 VZeKFpMY33nCNLIWNSJSfAftkN66XL0snaXhDUvx8fUL1qO6idwrinTVLIWjK/X1mN3xWud/29/oi
 nVtBD8lP+FEiPUhERaU2ukfFB6VFL+bJFY3WEUzpkbWpussyefLWWkFNsoAyMN/7mpqA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:
 Subject:To:From:Reply-To:Sender:Cc:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YcC18MwU7reQdlDJEAzOSvGKZE6b154t0b5VERSvP7Q=; b=Q
 a/Vc5I4D0ep3WUV22SQoqZ43zTgMucRtAn7IX7ItnkdRg9mVYJlX7l1ZMHnhS9RVPuVhwB0xIrMF7
 oqKAX7Wb9mCYZM2ocJEfZGe3UZ0D4aY47rkIZfUvhXKPnQRrVlK3xsujTFBqMpHDFxXk+G1oW3ZOB
 kXGvOEDQOC7CFJRY=;
Received: from [122.163.123.165] (helo=icompucare.my)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtp (Exim 4.95)
 id 1viv02-0001Ii-3X for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Jan 2026 13:45:26 +0000
To: linux-f2fs-devel@lists.sourceforge.net
Date: 22 Jan 2026 18:54:15 +0530
Message-ID: <20260122185414.65835A5A00472F56@icompucare.my>
MIME-Version: 1.0
X-Headers-End: 1viv02-0001Ii-3X
Subject: Re: [f2fs-dev] Business Loan Offer @2%
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Maria Torres via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: cc4921290@gmail.com
Cc: Maria Torres <sajiv@icompucare.my>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net


Warm Greetings support.

I have been trying to reach you on your telephone contact but no 
answer. We offer Corporate and Personal Loans at a competitive 2% 
 APR,with flexible terms and no early repayment penalties.Loan 
terms range from 2 to 10 years, and we reward brokers or 
referrers with a 1% commission. The Minimum amount you can borrow 
is $20,000.00 US Dollars to a Maximum of $10B USD. We are 
interested in investing in business opportunities globally 
including equity investment.

Kind Regards.

Maria Torres


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
