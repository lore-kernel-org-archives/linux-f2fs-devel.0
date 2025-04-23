Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5A42C369CB
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 23 Apr 2025 16:16:03 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1u7clV-0001xe-59;
	Wed, 23 Apr 2025 16:16:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dmantipov@yandex.ru>) id 1u7clT-0001xO-OE
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Apr 2025 16:16:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SNKKXSO4YGgOXC6gssOqfvI6gdGWucHkmbWV7afKv6U=; b=gAV3krS0Cou/fkqHf+bgiu2eLZ
 G3Epdg140VehNq7atHmDwui7Z0ak72Xmt0n0cTYrX9tP4Rj38fcvCCdPnPRXburEr5t0DGJInCAHA
 cJFukPB8+O/h+F5wk0BuhWxNnW09lB5BNGPTbIyTHqje9yJHjP83RlpzaXtDM46ATkXo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SNKKXSO4YGgOXC6gssOqfvI6gdGWucHkmbWV7afKv6U=; b=h
 kP/nrxxk4Zk4CkotGkHaUZhh74Q32N9B9E4jRQXT3xJdMfzp8SbeVQEg0+wivgFIe2bwd1XwD3D0c
 QdWWEXOZAuEUtBuvkdngfPZBrIqHQRqZZbmLsAGFH+GNAv5tEw4ULctbZ95RS4yW8whIh1x7pWRrA
 xAXW4DXFME010l60=;
Received: from forward101d.mail.yandex.net ([178.154.239.212])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1u7clD-0001yU-5o for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Apr 2025 16:16:00 +0000
Received: from mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net
 [IPv6:2a02:6b8:c42:67a8:0:640:8b81:0])
 by forward101d.mail.yandex.net (Yandex) with ESMTPS id 8FD2760B21;
 Wed, 23 Apr 2025 19:15:35 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id YFSFXuKLemI0-Eh28aOYz; 
 Wed, 23 Apr 2025 19:15:35 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1745424935; bh=SNKKXSO4YGgOXC6gssOqfvI6gdGWucHkmbWV7afKv6U=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=pp2TTRFwdg1XxqGNeVt7ut1fOkJ3FJS/igJHwZAV8dM1JzqaYgkXsFF5i3OXbNjNk
 dB5uRT59JD1ManU6IxGGrt2sOiN2ynkqlUg0QbuOi+Zu/5ugLNYb9gOf9Sw2qgoAkM
 QyYBsZtXtG5FBzFqeC1Ld80lBcjXDXhkoj3L67wc=
Authentication-Results: mail-nwsmtp-smtp-production-main-81.klg.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Wed, 23 Apr 2025 19:15:27 +0300
Message-ID: <20250423161527.152834-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.49.0
MIME-Version: 1.0
X-Headers-End: 1u7clD-0001yU-5o
Subject: [f2fs-dev] [PATCH] fs: f2fs: end all corrupted fs writes with
 -EFSCORRUPTED
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
Cc: syzbot+803dd716c4310d16ff3a@syzkaller.appspotmail.com,
 Dmitry Antipov <dmantipov@yandex.ru>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

In 'f2fs_write_end_io()', end all of the in-progress writes with
-EFSCORRUPTED if the corresponding error was detected earlier.

Reported-by: syzbot+803dd716c4310d16ff3a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=803dd716c4310d16ff3a
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 fs/f2fs/data.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 54f89f0ee69b..755806868f0e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -320,9 +320,11 @@ static void f2fs_write_end_io(struct bio *bio)
 {
 	struct f2fs_sb_info *sbi;
 	struct folio_iter fi;
+	bool check;
 
 	iostat_update_and_unbind_ctx(bio);
 	sbi = bio->bi_private;
+	check = is_sbi_flag_set(sbi, SBI_NEED_FSCK);
 
 	if (time_to_inject(sbi, FAULT_WRITE_IO))
 		bio->bi_status = BLK_STS_IOERR;
@@ -331,6 +333,11 @@ static void f2fs_write_end_io(struct bio *bio)
 		struct folio *folio = fi.folio;
 		enum count_type type;
 
+		if (check) {
+			mapping_set_error(folio->mapping, -EFSCORRUPTED);
+			continue;
+		}
+
 		if (fscrypt_is_bounce_folio(folio)) {
 			struct folio *io_folio = folio;
 
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
