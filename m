Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46E10CA5FD4
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  2 Oct 2026 11:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Lt/udFX4k113j2vGxHdAmOsyzitT5cicnyDj95Hc0iw=; b=K4CStlwOCyRiPD8oQeEeUIYkLV
	XAa+tluqxLkpJ8sfR+nYnP0S5lBxqMwNiR7QoApTyxd40Pyq9RsS98BDvHea10fQQQZN1NURryium
	oWriGN5TjERCW9a24v8VM09Xh0i8eMWDISTRsGgAAfi8LigwcWv1hsKJhKgSUZQTH5/0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xCbgV-00053o-5Z;
	Fri, 02 Oct 2026 11:44:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nsvatoslav515@gmail.com>) id 1xCbgT-00053i-NK
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Oct 2026 11:44:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3LqV8SJyA3fVrxqK5qwu4RqfJsKEdIb5icKMnaFaY1s=; b=QEi78vMpEczrO9KW4RdD4oZV0T
 ZLHwjhH2AH2vsm7hjZKzJOkgdG/63nDqfzcetoY9+OXW3mcgNRB+cznhMectE5ST8i+/Zh7qSGZS1
 RbyujDzNWM1nTnhnQfkqN5ydKcn74QqBT3XFmyMc1J94giqrxfQ9EM9c+wvQuHVKK3pw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3LqV8SJyA3fVrxqK5qwu4RqfJsKEdIb5icKMnaFaY1s=; b=h
 OlRnPHBNlmyYnix2RrvQ4OtP0pk4Vnv8UUyIo8gZNbuRTMOwAAjon7ynKzR0rKl+101k37+6FilxH
 mENdeByr3hNAWznvJLrgSJjTskER6RslxyywXjyu0BVaftoQNlVO6XG90ChGJEWqwJDrc0L+hQsbI
 7SrdOWKgAtdeM2Jg=;
Received: from mail-ed2-f31.google.com ([74.125.228.95])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xCbgO-0005jS-Fj for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 02 Oct 2026 11:44:11 +0000
Received: by mail-ed2-f31.google.com with SMTP id
 4fb4d7f45d1cf-6af85996a92so1120198a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 02 Oct 2026 04:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790941442; x=1791546242; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3LqV8SJyA3fVrxqK5qwu4RqfJsKEdIb5icKMnaFaY1s=;
 b=pS3imc4RUxtp0woqTBRfnWCkMeqIYO1W5cW5W6MFU0h3SZrDWuZRxW1YzFjEJzsGVp
 7cB+0p6DNHYZJHwaWTp+9Avd/GdaKSae/KS3Mq6Rzw12PugdZEMJwii9ENsokfme21i/
 uhN8fCNqa7PdOsiXaOn8ditF/Cuk83gbN6+b3ziNK/7PQFikngDqFQVuBqxLgLXTQeJo
 tTYiJppGp7QaVadcQHp0UFJ4Vz7JC2phkXGLPFFEeS+hMrJGpgJ7iNE/QrsdHiCbekK6
 UGU9ITUibMmW1waAsNYlt1QpZc0a5a3ueNHmJc7qIn9RePuBAr/8Mw0X3bd5gPwlzgOO
 4yRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790941442; x=1791546242;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3LqV8SJyA3fVrxqK5qwu4RqfJsKEdIb5icKMnaFaY1s=;
 b=M4bRILfzJZXFV9aB5g4+hMQHiFe7jvWXcYetsFDxj7eTplODKiMtthMZkGhYH4ncsI
 fRUvNyKfO4bYA3IJlMlnE1QrHosBN66dF5JLD/Vaecc64sD6PaKDiSz3GKj/rgTBYAiO
 vD5XzxwfdZUHa7Se/hDdO8yFAZANAXmMucgSu5xjB+40OuLbZvOOUDkFTAZnmFjo5mS4
 NW0P1s0CIzc7BXpOm/oOviQdvBgXSDevB56Kkv/XfcJwAhA/CV3eV50J/UCPWMWPFwEu
 ZogLrzhEYxsqZOATzyR+PEOrCVncSjXb1RDdXCjUZZsZVjBpoUYFvDlAEJHe00J6V9Lg
 JhDA==
X-Gm-Message-State: AFq9FYKBXZQJzLaDDIjjPpHpPPauvPD7OLGh/h7xi0VAbOkywbCExf1M
 S3gqEk1NvX7OLfj8JfgVoR/8thAtyi9l4gbBWI/teLIDq9PLPc4+3CYe
X-Gm-Gg: AYBFou1kCWiDQPrI86aX3AH27I4XOyEEB4krETDoLLPiaTeM4v1oVz6EoF1jPJ5rP8i
 ohZm92pJmu5brudVM30t5l9SAtzSshGenNUZOdDOl3zEMXnFB3tHB6/LqosWNyZF6tU8/KePnOV
 RNBDAGWcJ6c+th0elXc3n/5p3PKHzLN4Q7zO80Uo9uPsJq2B2qBoWVcyi4RbhZtm/dgsT47+4vJ
 gK0j42HgHhVKtDnhoADPk2NKxSBDX1pf9taurGhsnJzu17EIXspAKqD/SrOtO6zF9QVITnSncxD
 FOa0kBlGbaLIZ3ccfWjqqh2pNzbxID3C0TLV5rCxKGqc62Bd8AXKeylPBGvSuiqNVErYvng5i6z
 4OsPUE7V+Eb0LcufM4pnffjfHmQwaQYeEUsTgTjHWVzNfybT7dH/cYRUOOtGlIKa16rrrmDY+yc
 f2u49jKXzGsnDzcTzYnTlvJL0wAdrKmEezzJ0AH3u8b9yKxwmSHflrjBNa4qZ8nkOfWKQv8a0lN
 6XpKBdri3NKJ1Hi8Z1YBErynOw=
X-Received: by 2002:a05:6402:24cb:b0:6ac:62aa:e3bc with SMTP id
 4fb4d7f45d1cf-6af9e2d7d26mr1281088a12.9.1790941441665; 
 Fri, 02 Oct 2026 04:44:01 -0700 (PDT)
Received: from localhost.localdomain ([94.240.182.136])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6af9d8b1ec6sm810886a12.27.2026.10.02.04.43.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 04:44:00 -0700 (PDT)
From: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Fri,  2 Oct 2026 14:43:37 +0300
Message-ID: <20261002114338.12073-1-nsvatoslav515@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
X-Headers-End: 1xCbgO-0005jS-Fj
Subject: [f2fs-dev] [PATCH v1] f2fs: convert pagecache_read() to use folios
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
Cc: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Replace page-based APIs with folio equivalents in pagecache_read()
to migrate fs/f2fs/verity.c away from struct page.

Signed-off-by: Svyatoslav Nikolenko <nsvatoslav515@gmail.com>
---
 fs/f2fs/verity.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index ee838f880c4a..69bdd22ba96e 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -45,18 +45,21 @@ static int pagecache_read(struct inode *inode, void *buf, size_t count,
 			  loff_t pos)
 {
 	while (count) {
-		size_t n = min_t(size_t, count,
-				 PAGE_SIZE - offset_in_page(pos));
-		struct page *page;
+		struct folio *folio;
+		size_t n;
+
+		folio = read_mapping_folio(inode->i_mapping, pos >> PAGE_SHIFT,
+					NULL);
+
+		if (IS_ERR(folio))
+			return PTR_ERR(folio);
 
-		page = read_mapping_page(inode->i_mapping, pos >> PAGE_SHIFT,
-					 NULL);
-		if (IS_ERR(page))
-			return PTR_ERR(page);
+		n = min_t(size_t, count,
+				 folio_size(folio) - offset_in_folio(folio, pos));
 
-		memcpy_from_page(buf, page, offset_in_page(pos), n);
+		memcpy_from_folio(buf, folio, offset_in_folio(folio, pos), n);
 
-		put_page(page);
+		folio_put(folio);
 
 		buf += n;
 		pos += n;
-- 
2.47.3



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
