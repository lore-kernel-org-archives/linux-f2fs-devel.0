Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE756C5DF97
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=sXMsegAqJPDK94Hv2mjAD1FqFxDLvMNYLFiVSXWgUZI=; b=Po4Df9lY7LBlpBENl1Zo9lho9/
	ALxgKkjzmtT6u6WzZSDUeA7jYV4t/jg/sAoSdvs8+/t9ucEBfdvr7PuBJjJLF+tPxHrNx1jn/XG+5
	JYW9ni/zjuHHXdgOjy2S0+ZgtgQ0Q4FJRPfFEPzkYIzIx+epsYYtrvTR0UrDG+etuXmc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzFH8-000796-Ap;
	Wed, 26 Aug 2026 15:10:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wzFH7-00078y-MM
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:10:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D930K8rAR0nqPO9iHXUpAMFsmi4kK4OjA4PRKGa48u8=; b=k1Dbgexp+ajOorFjiM3vCkhyX8
 Xg4zFxWTn7ACSLo9hT1FJJurAK3nkoo4N/DIe3c2UwEviK4tC8bfthZKe9gSkjwbROlwRFYX6mtEn
 MHWB0ch5hBKtuWBOjwNie+6YbS1CZ7XtxVXFjTYY7YwaDlqgjPOKNHXWO/WXbKJFaEtg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=D930K8rAR0nqPO9iHXUpAMFsmi4kK4OjA4PRKGa48u8=; b=O
 53WubEyLQuTD1aW/O5ShMNzZ3PMb7UpCDpXF0feIRi6yxd4WOXifJqGtk2tugAVBfY+kMSVC/AJJD
 bZtvc5CLeDrW8I5t/AL8+1TGQvlMVINqGlV787NTo1Eu4pRHksonUzP0B3YDtBpFv9rT4kydXjvSQ
 hRLOmV6PeJnmpKVM=;
Received: from mail-yx1-f53.google.com ([74.125.224.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzFH4-0006nF-Q5 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:10:47 +0000
Received: by mail-yx1-f53.google.com with SMTP id
 956f58d0204a3-66d25d77713so928547d50.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 08:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787757041; x=1788361841; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=D930K8rAR0nqPO9iHXUpAMFsmi4kK4OjA4PRKGa48u8=;
 b=GSrnj6aUIeHGB3+ScXhUHQqBN6dhFpaHl6nukjbRAB19UK0VZ7U96cdm4VSCJGCr11
 zw0VhCGJYlquNQmlhwIckl5MLmvOU2hlTORC/xJ9AsOn8KLriugubjkQPN/SazB6F5df
 dXYkOW7l0uqbcODD8F2JJ1+wlUPZANQf6nodsC+fOazZxweetHsFHARtMtFg162LlKlJ
 ySeAsXvGGV66zn+Bld9ZrnUGHjXDo4HvGYOLq+iHA1vu+el9jC9AeM/VL8rx29sV7T5V
 IUM7oQS+KMJDRSYL2kB3G5kl8dN8bB3lxGn2IeuPu5y0KmHYWOuRcDqbq9PHf+H38g9S
 ZIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787757041; x=1788361841;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=D930K8rAR0nqPO9iHXUpAMFsmi4kK4OjA4PRKGa48u8=;
 b=B5EZTahPaxVF9NA3p5MKEY5E/i/mZEqGdQsDC9ilvplbdrpjMXnGemy8S/5krb4Xd5
 cT5FJBtj2J0BEzqLR4YNlObCl2AniAbsH5/YYL8aAbpdL95Z1nVdICO09Ddjxxg2xnk1
 uF3f32KnCuGUceyWX5NhCEmCWFlNMjj3OO/2pd7ZOG5mZ3ksVVgeMQanubPIhRRgllcm
 IomlxlB3kuib7j1Mb26nufskarHSM5zJ/nDgBAFDO78rPbhtwl9n6RTDQoOSJXBo213L
 LQIVDUu37uC5ovI3LXlYSHFeyvaFCtxLOUQxH3q/UJCuGHsluRSgfPvZpPTNkCmKRIwS
 zjpg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr6OesMjZM9RRhX+CdWn3ZLny5jyayW9x6sl9hI2JJeaT3GsgX8Rjqe1rYv2vTDVCtkwYw7LXKb+x5mfJ73CPDg@lists.sourceforge.net
X-Gm-Message-State: AFuF++nAvgYAjJZtGCznXIVk5xrqBznOMvd4KbwzO/nEBYaxL0IZ/c93
 5nYeWaGUNctwymDjLWpI6skcbzAe/Nb5NZe598Hji5YFo/E/4iYok1QiB2gwZCUG
X-Gm-Gg: AR+sD135EU3IWrtW7Y4BHD+b3Uk/iHxXX5CJfkn2u9hzjtI7UjamFBiOcB6XFcc0fRu
 4A+Tei86aFhEwRynPygUNksZ4tLW6MPPWeGeWB41LSABPa4Z20qr5zv8SVmZY1KpwjhpYeA2uxY
 kzRiKRCBJeHjK8f8ejgNQfTC9/08AzAJAzz7mej6bglqTJOX/BGy3Lcegcws0yhMRlkGzLWEyZN
 ESJHeWSQTchvOzsvnlvT6HOk9mwk4abgn4YqwNiNwzJZKUhFpIZcpdebvTK+AneqLIXnTafUjiq
 Kox8UrNVg/s67uEDDhQLT7cq7Yd+c2FZ/X0JVHcBpQdR0Xdn4XBoNEiie5L3du0g5TAyuUUA1rX
 4APtp9Gn3vxFzgEQoa96/9QS8haFQbjw5L5vwMQni0DloitoK0Y1crt+GyEZEJ7HDKEsIIUHZkL
 htTW/wKE1H4uJuneUG6rxxawIYf/nNrKODP/kTfus+mNDuF0HtR7QDBwAGFT2dkPV8VQBx5L1K8
 njAsy5MsocL+0hUEnqW/7E2
X-Received: by 2002:a17:90b:54cb:b0:37d:f206:a2ac with SMTP id
 98e67ed59e1d1-3966d5b7c62mr15789485a91.7.1787751760209; 
 Wed, 26 Aug 2026 06:42:40 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396825f2d32sm2191360a91.10.2026.08.26.06.42.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 06:42:39 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Wed, 26 Aug 2026 21:42:33 +0800
Message-ID: <20260826134233.3730099-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wzFH4-0006nF-Q5
Subject: [f2fs-dev] [PATCH] f2fs-tools: persist device alias inode in
 superblock
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
Cc: qwjhust@gmail.com, qiwenjie@xiaomi.com, daehojeong@google.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Mirror the kernel dev_alias_ino array in the superblock reserved area.
Initialize each entry when mkfs assigns the corresponding alias inode. Do
this before calculating the superblock checksum so the mapping is covered by
it.

This is the f2fs-tools companion to "f2fs: persist device alias inode across
remount". It keeps the superblock size and checksum offset unchanged.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 include/f2fs_fs.h  | 3 ++-
 mkfs/f2fs_format.c | 6 +++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 1b24a3c..7a127b9 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -824,7 +824,8 @@ struct f2fs_super_block {
 	__le16  s_encoding_flags;	/* Filename charset encoding flags */
 	__u8 s_stop_reason[MAX_STOP_REASON];	/* stop checkpoint reason */
 	__u8 s_errors[MAX_F2FS_ERRORS];		/* reason of image corrupts */
-	__u8 reserved[258];		/* valid reserved region */
+	__le32 dev_alias_ino[MAX_DEVICES]; /* device alias inode numbers */
+	__u8 reserved[226];		/* valid reserved region */
 	__le32 crc;			/* checksum of superblock */
 } __attribute__((packed));
 
diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 66f2e4d..a92b605 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -644,7 +644,11 @@ static int f2fs_prepare_super_block(void)
 
 	if (c.aliased_devices) {
 		c.first_alias_ino = c.next_free_nid;
-		c.next_free_nid += c.aliased_devices;
+		for (i = 1; i < c.ndevs; i++) {
+			if (device_is_aliased(i))
+				sb->dev_alias_ino[i] =
+					cpu_to_le32(c.next_free_nid++);
+		}
 		avail_zones += c.aliased_segments / c.segs_per_zone;
 	}
 
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
