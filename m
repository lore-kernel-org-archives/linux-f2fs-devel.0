Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F07FCC6B38
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 16 Oct 2026 05:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:Message-ID:MIME-Version:References:In-Reply-To:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ehQm9Q49MqnCd6yynfD/RBB1CtBiSPzDQ3YBmw4mngU=; b=KEF2/cBCoT1UYELSm6Ldr3jHNA
	eqLXJT134E5J1VgodlKh9mo4LVPqaS+Kq2ZYA61I+U98Bu/dsfSs7Zdnj/IbnnNi5Ji6lJJ8s/hSI
	gBTg3sieVfikYpa5MmAJ+LgwI0FHFzBJF84ttnRK8zLA3vX4cz877zWosGfdshsMrSxE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xHasi-0001e5-Ck;
	Fri, 16 Oct 2026 05:53:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1xHase-0001de-O1
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 05:53:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:References:In-Reply-To:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gxxJ7t8PmHmqWd0Zl5m8j55pw8ZjQSvr1vPwKZmXGhE=; b=VeEftYiATjDZIwlxFB1yfkM0fV
 COEXffVzkDsW4j/73FiA6HARX0P2k61s3kkNiL9fM2fF9gCIghUOEFp4Y6HgTUuggDEwQQ/QT4q6D
 +8o9x9KU72kNANy+WDnycqvnY9OG8AxPcihCKV9/7K5mK9baocLQ1bDvsK3rTUZO0osY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References
 :In-Reply-To:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gxxJ7t8PmHmqWd0Zl5m8j55pw8ZjQSvr1vPwKZmXGhE=; b=T6hpadDODN6nM1C0ekDwm7/dWl
 5M5sntf1RaRtrbfD31PJdfnx3m+AaIhB0opnq2svJgFjkK/32PgZ3Tg1AyKYBokRM/CAirJYSEw80
 16FGmzBtZm4KqoV74VhGi4j/bLzmA+T0Ta2Rmo0EZq1ZxNst7nm/BHgkG0F+A/UsSgIg=;
Received: from m16.mail.126.com ([220.197.31.6])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xHase-0002n4-Hv for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Oct 2026 05:53:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=gxxJ7t8PmHmqWd0Zl5m8j55pw8ZjQSvr1vPwKZmXGhE=; b=m
 st5Lq8IvndQW9xdfHyEs2JAK34IG5zslFY/Y9w5nIJWqhL04SITsDt9idWa7bBad
 7SBJi2frhnqpX+bjTN6UzNGdYUu2NWbMFzn+edONYuVcu9BMrsTnvw1ir10GTW1o
 ubINAw90l/EhGF2zOW6zsTFH5l+OiZONnyw7joyZn0=
Date: Fri, 16 Oct 2026 13:52:48 +0800 (CST)
From: "Nanzhe Zhao" <nzzhao@126.com>
To: "Chao Yu" <chao@kernel.org>
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20260511(2e539873) Copyright (c) 2002-2026 www.mailtech.cn 126com
In-Reply-To: <1349f52e-af6d-48ab-b06a-4c8f5b3f7e68@kernel.org>
References: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
 <20261014064445.2835813-4-zhaonanzhe@xiaomi.com>
 <1349f52e-af6d-48ab-b06a-4c8f5b3f7e68@kernel.org>
X-NTES-SC: AL_Qu2SAP2ZtkEt7iaRYukdmEoVj+o8Xsaxs/8g2YJSc80OnBD3wjIGZFNdN3b84eyRCCG3vRavXhpezMdoeLh5/no9kIvx6gZOH46EorBpHQ==
MIME-Version: 1.0
Message-ID: <7ce0ac29.3f00.1a143452a3e.Coremail.nzzhao@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: cykvCgCXf3ewu9Fq5apQAA--.31231W
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBoxAq+WrRu7Bx9wAA3W
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Headers-End: 1xHase-0002n4-Hv
Subject: Re: [f2fs-dev] [PATCH v5 03/16] f2fs: support regular file buffered
 writes on large folios
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
Cc: Nanzhe Zhao <nzzhao.sigma@gmail.com>, Barry Song <baohua@kernel.org>,
 Juan Yescas <jyescas@google.com>, Daeho Jeong <daehojeong@google.com>,
 linux-kernel@vger.kernel.org, Pengfei Li <lipengfei28@xiaomi.com>,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 linux-f2fs-devel@lists.sourceforge.net, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net



>> +	f2fs_submit_page_read(inode, NULL, folio, index, blkaddr,
>> +			      REQ_OP_READ, false);
>
>@for_write: true? like we did in f2fs_write_begin -> f2fs_submit_page_read(.., true).
>Otherwise, it can run into mm reclaim after holding folio lock, causing deadlock issue
>potentially.
>
>Thanks,
>
>> +
In fact Sashiko also reported this issue, I've got a bit hesitated to chang @for_write to true
though, because I know that we already remove GFP_NOFS in folio allocation. And I also
check shrink_folio_list and study shrink_slab and swapfile in nowadays mainline and didn't
find a deadlock issue. But I do miss to take porting large folio on older kernel like 6.12 into
consideration. Anyway, I didn't receive report or test data on direct reclaim casuse by bio allocation
with GFP_NOIO, so I'll change @for_write to true in v6.




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
