Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91474C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 20 Apr 2022 07:08:10 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nh4Rc-0006lg-27; Wed, 20 Apr 2022 07:08:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <xuyang2018.jy@fujitsu.com>) id 1nh4Ra-0006lX-7n
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Apr 2022 07:08:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:Message-ID:Date:Subject:
 CC:To:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=x1C8lx1JZTXe0stF+e0jPGVSoNlKRTUkIzjzqZCG37s=; b=UQfQpu6rFiRnjQqGTlkESgNCiH
 vHa6h6gyiMZiQXLqdYI/OPfKCdNcC9dPDzY56DMaxlBXefWl3yc78gXjTdcRdgq0YpB4ANZ0ANMzi
 HT0X7RfVrmpzEVnxM2yCR4mLy0kd3VOGmGFoFLR28ikgqpLRSvxHJfXKfvOOHVwbPI/Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=x1C8lx1JZTXe0stF+e0jPGVSoNlKRTUkIzjzqZCG37s=; b=c
 5Y1/xm+M8r0r2XZGv+yQa2S5L16uQGo9JDNa9szPBAkV/v2Zy+iOftnr2PjgSADg8rVK0l2LhGqKQ
 +Y8ju+FCZhKxFOSC0mI4jHbgd2cJK4lZwLX8HV7LqPNmpeCHnl3jlGeivdEnoa2EUmQRj8/51abpt
 aX5Wr9HjkNnsRXZE=;
Received: from mail1.bemta32.messagelabs.com ([195.245.230.66])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nh4RS-0007d9-CO
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 20 Apr 2022 07:08:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fujitsu.com;
 s=170520fj; t=1650438466; i=@fujitsu.com;
 bh=x1C8lx1JZTXe0stF+e0jPGVSoNlKRTUkIzjzqZCG37s=;
 h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type;
 b=gEhGEiVW2NXpDHxZlGiWRQDfZqqeXc5/tcakDVwkjNAbZ0Axw2fc+pfe/Q+PDqePo
 WOECLB8/WPpXpprp3AdA8R+ndccIONe3Hlcnq5jByiEFA3z7ArIvR+nxiqxaptLoRV
 oemilOsgWeCcBV4DoN1FnJXSLXH7RXlQNHVpCU2bb+xiYCdTOm0YZ4WZlIwb+WtvXB
 4vAN9TXbjWhPd5aCwEaH9JYVsufkDg6/4uyt7dbNph5ER22cw3fcWQ5cSSewZ32yqO
 HiPqo7gzowYHt3x71KIUz/5+tlM50IfXJUmBFybFNOh9mzv9TjtkytTj9638evqZIq
 BCef74DF6U6MQ==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrNIsWRWlGSWpSXmKPExsViZ8ORqOu0MT7
 JYPEHYYvTU88yWVxa5O7A5LFpVSebx+4Fn5kCmKJYM/OS8isSWDNauw6xFWxnq7j78w57A+MO
 1i5GLg4hgS2MEqt37mOCcBYwSXz6/oIdwtnDKLH3z162LkZODjYBTYlnnQuYQWwRAVGJNd0bW
 LoYOTiYBYIkft4PAgkLC/hLbDo3jxHEZhFQldh44Tc7iM0r4CFxcvlcFhBbQkBBYsrD98wQcU
 GJkzOfgMWZBSQkDr54wQxRoyhxqeMbI4RdITFrVhsThK0mcfXcJuYJjPyzkLTPQtK+gJFpFaN
 VUlFmekZJbmJmjq6hgYGuoaGpLpA0MtZLrNJN1Est1S1PLS7RNdRLLC/WSy0u1iuuzE3OSdHL
 Sy3ZxAgM05RihuodjP97f+odYpTkYFIS5T27LD5JiC8pP6UyI7E4I76oNCe1+BCjDAeHkgSv7
 zqgnGBRanpqRVpmDjBmYNISHDxKIrylIGne4oLE3OLMdIjUKUZFKXFeoaVACQGQREZpHlwbLE
 4vMcpKCfMyMjAwCPEUpBblZpagyr9iFOdgVBLmLdgANIUnM68EbvoroMVMQIurp8SCLC5JREh
 JNTCdzOncpdh7Q6z7TcHDiAlbrGOubLueb8t98LWV22Pee3/+X3kplmq7jvWZQFPJW4klu7It
 5/q6aX3bo9y96nDv5N+Ln3Gqc1+dbCo8J8v3wRalCU+Tcj44RLU+PfVlMsfjWbd3HJnNH7tmn
 56gS/OerhfP3Hc1Kbtqr7kbd3w+t81W3m/bts3sDcljnVSXptYy51hhn5Xjs33PssVO9wddY7
 yUIlSk/UtOtfRhQptRe8dGHucjjVkHy8vz1p7/FbmxSf164tQrlavmKHXn/Ltke3bG25IlS+P
 vH6tZ23UttLEwXWv1weNmke/mXzlQ/Ob5DvtXXoYH1Zbb7pA+olRz0LsvRsB2mdPseazSXVXX
 lFiKMxINtZiLihMB3GRzhE4DAAA=
X-Env-Sender: xuyang2018.jy@fujitsu.com
X-Msg-Ref: server-6.tower-587.messagelabs.com!1650438466!341859!1
X-Originating-IP: [62.60.8.97]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.85.8; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 3641 invoked from network); 20 Apr 2022 07:07:46 -0000
Received: from unknown (HELO n03ukasimr01.n03.fujitsu.local) (62.60.8.97)
 by server-6.tower-587.messagelabs.com with ECDHE-RSA-AES256-GCM-SHA384
 encrypted SMTP; 20 Apr 2022 07:07:46 -0000
Received: from n03ukasimr01.n03.fujitsu.local (localhost [127.0.0.1])
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTP id C639610019E;
 Wed, 20 Apr 2022 08:07:45 +0100 (BST)
Received: from R01UKEXCASM126.r01.fujitsu.local (unknown [10.183.43.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by n03ukasimr01.n03.fujitsu.local (Postfix) with ESMTPS id A2473100197;
 Wed, 20 Apr 2022 08:07:45 +0100 (BST)
Received: from localhost.localdomain (10.167.220.84) by
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178) with Microsoft SMTP Server
 (TLS) id 15.0.1497.32; Wed, 20 Apr 2022 08:07:28 +0100
From: Yang Xu <xuyang2018.jy@fujitsu.com>
To: <chao@kernel.org>
Date: Wed, 20 Apr 2022 16:08:30 +0800
Message-ID: <1650442110-2763-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
X-Originating-IP: [10.167.220.84]
X-ClientProxiedBy: G08CNEXCHPEKD07.g08.fujitsu.local (10.167.33.80) To
 R01UKEXCASM126.r01.fujitsu.local (10.183.43.178)
X-Virus-Scanned: ClamAV using ClamSMTP
X-Headers-End: 1nh4RS-0007d9-CO
Subject: [f2fs-dev] [PATCH] f2fs: Remove useless NULL assign value for acl
 and default_acl
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
Cc: Yang Xu <xuyang2018.jy@fujitsu.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Like other filesystem use ${fs}_init_acl and posix_acl_create function, we don't
need to assign NULL for acl and default_acl pointer because f2fs_acl_create
will do this job. So remove it.

Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
---
 fs/f2fs/acl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/acl.c b/fs/f2fs/acl.c
index eaa240b21f07..9ae2d2fec58b 100644
--- a/fs/f2fs/acl.c
+++ b/fs/f2fs/acl.c
@@ -412,7 +412,7 @@ static int f2fs_acl_create(struct inode *dir, umode_t *mode,
 int f2fs_init_acl(struct inode *inode, struct inode *dir, struct page *ipage,
 							struct page *dpage)
 {
-	struct posix_acl *default_acl = NULL, *acl = NULL;
+	struct posix_acl *default_acl, *acl;
 	int error;
 
 	error = f2fs_acl_create(dir, &inode->i_mode, &default_acl, &acl, dpage);
-- 
2.27.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
