Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 860A3C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  8 Jul 2026 06:55:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Tb6F7oIrrr0ao+jlfXlg/OkgJHroXrJZAQOLAGMsKys=; b=P2116NUvr6HPdipbuWbQy+tsRL
	Spk1OMl3QDs0FoSiPzfUsGyo6p0TRVGUwSioiWwdkH0KuwU+jV7P8+Vgd0mND7zpYMRLoxKNoVklu
	5i3VAYVWe+H/Bmd20e4jL8lG5eGSMQUrMx0KkdXgbgEUN3hXpGrOV9+quo7reZPbEjB8=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1whMBQ-00040O-Gm;
	Wed, 08 Jul 2026 06:54:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <alvinhuang0603@gmail.com>) id 1whMBO-00040G-MB
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 06:54:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/B8K3OwEfLGyztVIceSp+/GraQ767IL1vulmM4eozHs=; b=KGY48Aq2q1XOBYZ1KhksUUokJ7
 sBYSh5tzOprQ8XUfwe4XgAbchLXYEsFCBN1ZU5qIw6LjFMWUFFXPgD1L77ySMS8uP+prepEasTgFI
 U1PpN9+pf9A0IjjO4zLUiOH1dbSSryw1aUoPPWrPIor4ZTjL1sjgAwd0pcRzIjom7Ysc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/B8K3OwEfLGyztVIceSp+/GraQ767IL1vulmM4eozHs=; b=A
 TEfX7+o116x5wXLtOalZDbxWvfITW3r4YKa/+VwkTeN4oLex4iAZtueakuRzCgL0b+tc9mU23hDbR
 ZQ5vXduKGwnaVyJf4bEYCO8Pabw5paCgSHOlzEDNtw+1pMdlDIvGPq2ushYcp5flyWw6xANvzbKNn
 QTIgocIIKC8osKU8=;
Received: from mail-pf1-f178.google.com ([209.85.210.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1whMBL-0000X9-OV for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 08 Jul 2026 06:54:56 +0000
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-8481fb4324aso250838b3a.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 07 Jul 2026 23:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783493685; x=1784098485; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/B8K3OwEfLGyztVIceSp+/GraQ767IL1vulmM4eozHs=;
 b=qhSZQ9I1lPw/NDE+3FVzY8jWWWo0O2qJdfhfecGYWjSoovCwvOK+Uy2UYmgz0SMbf3
 WpkPlR3xcUxgdruxN0YXDLGE1LKzGrAcxcHwTl+LZVPAywDN4sZECBEG9nIbX5Srv3HA
 8kQegKWMB0rWDdVp0+IGOmaw6kClaYALoRTZCdcaAC/UIP+eXVHZ2tUAZX0wNfWobQ2d
 /UeDCSYesQXt7XlKOFO/FUu/D2nzsI8c7Qu1ejtEH2OmvbjOZHrgUzp1RKSektvGcXfm
 m8oyX0VD8OLXziQa9Tj8Qo0j8AjGAyWvSSv89IK4zEVeUmPojSeHzWQCKWl3fJ4bqjb6
 Q69Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783493685; x=1784098485;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/B8K3OwEfLGyztVIceSp+/GraQ767IL1vulmM4eozHs=;
 b=BUMv8hbqAExwPqqUgi9XJAUSSi7MtiW6FLMKzb39qlNekKwmIiKI0ocnNAsHiSDlCs
 GVbdrjnQH05azJYuPQrM1i3a5RcJr/xoemeAti/m2Nk9BKVT2BWmZkOZkJJOSbqbLqF/
 LmcYI2di7PfFDHEuVT9AVtClDEIjLPraFHTQp/OKEo87kI7uhq3z8BeO1rCK9voiEmhz
 i5YEchqxIm+ha3r6TRRAOm7tqcvk2ul4/oXIDv27AZqG56A4oADdC7egEltMggZYSQZ/
 mGB2xIHESZBwDPqb/gyyoG7oDKwYsMX0CGD1hpWjiaRqaej5CgOjYp5ReMnFvl56deNd
 Bvtg==
X-Gm-Message-State: AOJu0YzZmqxulqJXGonbj3MovlGbkPY6jf+C7aYR+Tqovxrvr1DarYP9
 SN3iVQ0z8Jt2d6IHX9lcUyB6bttZRKAlWskJrj1N1Phqm2mA6xYWf/v1
X-Gm-Gg: AfdE7clKagMZU4+5AwrEmaRfes6Spjfi9ci0F8cTJQjI6cEtKJxNjgf0zX/zTVlkvYR
 JBwE27/reAxrfnGlXpp4VyjBcsv3QNZhKqZOrgPG547PV7M5m9NRstnomCBI/rw6g+lKc4cfLTq
 kJMP+/1VzJogBklgEKeiIXVp9fAKxyToLMY0Vu3iO/LgrfDbumherfuVr+cEj0Xh9R1nCC9Pfqv
 7siIL1t9P2w9ZCMxcyvmq7XQQAvkq/Qhh9rIO5JdHl0DbA7WU84ijIg4ynSt/PifV5Y7f/lzJIf
 +xPzguA8+oRs+LlkdBUao8IpEMEIbou3zLLW7MVeb/v9uUXmoC56Br5sLhEccYxVis0eTg82XRr
 yyfzYyt2JY+qjE77M638OkHwDwyxWVN5if72lRAyOw4MURGagY3dYPqqrqaRqtxbm3SFlJRHTX/
 ND8OhXla0KLIWS3LXkRCfJqP0RHve5jEM0LQ==
X-Received: by 2002:a05:6a00:3e12:b0:848:3dae:66e2 with SMTP id
 d2e1a72fcca58-84842ee541bmr1343367b3a.26.1783493684900; 
 Tue, 07 Jul 2026 23:54:44 -0700 (PDT)
Received: from Alvin.tail8ccd9a.ts.net ([49.216.173.166])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6dbfd41sm6643216b3a.57.2026.07.07.23.54.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Jul 2026 23:54:44 -0700 (PDT)
From: Hao-Qun Huang <alvinhuang0603@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Wed,  8 Jul 2026 14:54:39 +0800
Message-ID: <20260708065439.1139937-1-alvinhuang0603@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1whMBL-0000X9-OV
Subject: [f2fs-dev] [PATCH] f2fs: reject overlapping move range after len
 expansion
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
Cc: Hao-Qun Huang <alvinhuang0603@gmail.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

F2FS_IOC_MOVE_RANGE treats a zero length as a request to move data
from pos_in to EOF. However, the same-file overlap check runs before
that expansion, so a request with len == 0 bypasses the overlap
rejection added for same-file moves.

For example, with a four-block file, moving from block 0 to block 1
with len == 0 is accepted by the old check because pos_in + len is
still pos_in at that point. The code then expands len to cover the
rest of the file and calls __exchange_data_block() on overlapping
source and destination ranges in the same inode, which is the
data-corruption case the overlap check was meant to reject.

Move the overlap check after the source range has been validated and
len == 0 has been expanded, so it sees the effective length. This is a
no-op for non-zero len (the value is unchanged there) and keeps the
existing early return for identical positions.

Fixes: d95fd91c1ac1 ("f2fs: exclude special cases for f2fs_move_file_range")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Hao-Qun Huang <alvinhuang0603@gmail.com>
---
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4b52c56d71f0..fdfef01dc799 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3144,8 +3144,6 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 	if (src == dst) {
 		if (pos_in == pos_out)
 			return 0;
-		if (pos_out > pos_in && pos_out < pos_in + len)
-			return -EINVAL;
 	}
 
 	inode_lock(src);
@@ -3171,6 +3169,8 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 		goto out_unlock;
 	if (len == 0)
 		olen = len = src->i_size - pos_in;
+	if (src == dst && pos_out > pos_in && pos_out < pos_in + len)
+		goto out_unlock;
 	if (pos_in + len == src->i_size)
 		len = ALIGN(src->i_size, F2FS_BLKSIZE) - pos_in;
 	if (len == 0) {
-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
