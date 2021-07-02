Return-Path: <SRS0=Mutv=L2=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.4 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FREEMAIL_REPLYTO_END_DIGIT,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C919C07E95
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  2 Jul 2021 18:40:37 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 007A06140C;
	Fri,  2 Jul 2021 18:40:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 007A06140C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lzO5b-00079N-9A; Fri, 02 Jul 2021 18:40:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <9sporst9@gmail.com>) id 1lzO5C-00078g-B9
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 02 Jul 2021 18:40:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Subject:Date:Reply-To:Content-Type:To:From:Sender:
 Message-ID:Cc:MIME-Version:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FNZtwLvrllRFWL+8hBj0nyO4zumHo8nebc8dxoTUJOs=; b=gH9wo2Xbvshvwt3l4ScaMOUqkC
 IEomxAno51M/SUN8u2zNIxyC9h/+yncI4FZaP/74ZmNnuRp9ldltXilp4hlt974mQJknCHjO74BQC
 yfC5+eUXMGF0v/Z5oF3yYuUk/f9vNBKLWj0bnwPFhjQgk1uO3T5DJzaCb10RvmQe51jE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Subject:Date:Reply-To:Content-Type:To:From:Sender:Message-ID:Cc:
 MIME-Version:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=FNZtwLvrllRFWL+8hBj0nyO4zumHo8nebc8dxoTUJOs=; b=B/zjMUkyqL/YHE/O4pL98v4Os0
 BnMoylI0u91DXU6/JZA8OFpeGGDc82C1dKgrvF8qSL3eZfT58gCFF+MpHZZ2HiKmf+rqCgwzp/XlF
 mgLyhD9jPYLyEnKWa95ZpGqL89i9q5sKo/DEj1C+O/5U0AUYauH2pYPVuP9WwHbQ8eCw=;
Received: from usa-4.svrip.com ([209.141.35.52] helo=hyh85i1.com)
 by sfi-mx-2.v28.lw.sourceforge.com with smtp (Exim 4.92.3)
 id 1lzO52-0002fN-Rb
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 02 Jul 2021 18:40:10 +0000
From: "Ms. Kim" <9sporst9@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Sat, 3 Jul 2021 01:39:53 +0700
X-Priority: 3
X-VA-Spam-Flag: YES
X-Headers-End: 1lzO52-0002fN-Rb
Subject: [f2fs-dev] [SPAM] my future investment ventures in your country
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
Reply-To: "Ms. Kim" <9sporst9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Message-Id: <E1lzO5b-00079N-9A@sfs-ml-2.v29.lw.sourceforge.com>

my future investment ventures in your country
My name is Ms. Kim Anong, A Thai citizen in Asian Continent but currently
residing in abroad, I trust this email meets you in good health, I just got
your contact today during a research about your country and I will say that
I foresee success of my future investment ventures in your country. I want
to invest in your country and I would like you to assist me in my investment
with moral and physical advises. Please do reply me as soon as possible so
we can discuss more.

I look forward to hear from you soon
9sporst9@gmail.com


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
