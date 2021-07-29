Return-Path: <SRS0=A5bl=MV=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91799C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 29 Jul 2021 00:41:08 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 546AC6052B;
	Thu, 29 Jul 2021 00:41:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 546AC6052B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m8u6l-0003oR-C5; Thu, 29 Jul 2021 00:41:07 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1m8u6j-0003oL-Hn
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 29 Jul 2021 00:41:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uNIc7pfoGu/FJThfBBj9+RPriWv7zO4JIA2SEJzetJU=; b=N5eBOjA9SCMfhW1eqmvAFFY1R3
 w93t+I3x7cXLIUGk9sgj23jQKAsen9nP7u1Im1hol2nizIH/8/3OKERaY17kFj922+tF4Tp6EZB94
 bY8Fw8OrRMYT7IvMvGFE2/nsKv5kPr/qFHBdeVrqqm+Ga7Yg3NXVNqjDEUMNcXqPh5TI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uNIc7pfoGu/FJThfBBj9+RPriWv7zO4JIA2SEJzetJU=; b=GMJa3LxePOWD/sJ9otEfx8LIMw
 DWXcPUvr2mfB2FOlecbEChoVgKX4AjeYBfgaiRJCa8xL+shiF98AKwaENNGythWBOXdXvFbYJq08+
 6LVe32kH6kPyxe0HIaC0A8eJM1Fn85xoEhPAeV4gO1SycUo7ulqCxfBQYIZgSWWUisG8=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m8u6d-0007TC-Hi
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 29 Jul 2021 00:41:05 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id A843C6103B;
 Thu, 29 Jul 2021 00:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627519254;
 bh=uNIc7pfoGu/FJThfBBj9+RPriWv7zO4JIA2SEJzetJU=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=OdyQCOsKhEDk9fPkieTeaxQN+hnutClJj5EUNp7HUhg8oXNR3w0AryUxZnQxWrUCv
 Eq66HIf/Y7hi8i2sG2U3ICf8Bpe08driDJnah557lnpQMWGVZuE+KHQ9YMFLo6iDEo
 2rCgB5+H90rEHaH2pdeeM5Sv1NOv1P22K58TWFyJDHgWWGU5Jmr5TH4G+aaXDUGvi/
 x1L2gA5CYtYWzK/CA5nXoOoizBq1AabMCzQKmo/AEtd3JNwSiE0PL9T6/lqYk42tZ7
 JnYCmWWUokYUJ2Mntn5gPWnPe7BmRQbmv7YQNM16u1Y3fzgbourJ9MXcBulFnWN++0
 ZT6jyeNs4HVSQ==
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20210726041819.2059593-1-daeho43@gmail.com>
 <f9555521-8878-2d46-36f1-3032bb8bbc0a@kernel.org>
 <YQA/orZ5wXjwWeyy@google.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <8c0d05d2-3988-a8a4-5403-1173f25b822b@kernel.org>
Date: Thu, 29 Jul 2021 08:40:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YQA/orZ5wXjwWeyy@google.com>
Content-Language: en-US
X-Headers-End: 1m8u6d-0007TC-Hi
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: change fiemap way in printing
 compression chunk
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
Cc: Daeho Jeong <daehojeong@google.com>, Eric Biggers <ebiggers@google.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/7/28 1:17, Jaegeuk Kim wrote:
> Do we really need to catch this in fiemap? What about giving the current

Yes, I think so.

> layout with warning message and setting NEED_FSCK?

Sure,

How about doing sanity check on cluster metadata whenever it is going to
be accessed, like we did for single blkaddr with f2fs_is_valid_blkaddr()?

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
