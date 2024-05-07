Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FC57C10F1A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 May 2024 17:56:46 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s4P3U-0004Y0-BS;
	Tue, 07 May 2024 17:56:45 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1s4P3S-0004Xo-Rr
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 May 2024 17:56:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ive3waDoK8gwDGEBUE2bkX5N+SnSEytp7ihvp6Bzhck=; b=OUV6ovGaZdU2sz4fvxt44NFRKh
 fJIKebJe25zrX2QeUQ0xvqq3qXx/uPucfp7mtpoV7eGNAN8P19LfCGXcGgdBzFRkc7u4cJBsnRa/e
 0RwcrFOSdROsKZ8mT7BixsMZgozBydUcT01cOYTnH8Qffp3Zj3UNFhcqCGUz4REhv7Uw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ive3waDoK8gwDGEBUE2bkX5N+SnSEytp7ihvp6Bzhck=; b=e
 NmWcblhYm0reA5GUOqwRJl1hB0oww/wY5B4QcHc/ZzHYKnYfFOh694DAdJo/MTGZdZEiW1jZ1wWBK
 a3K5kPeBY/qQAnjb52ANu3HVTITvqQSLe3XBENlKPYMKmj1funZjM8PqWMS6SuUWZhSS/vsArKF8Y
 Tii/j9ug5fbAccwo=;
Received: from mail-pf1-f182.google.com ([209.85.210.182])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1s4P3S-00061k-V3 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 May 2024 17:56:43 +0000
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-6f44dd41a5cso3323894b3a.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 07 May 2024 10:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715104592; x=1715709392; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ive3waDoK8gwDGEBUE2bkX5N+SnSEytp7ihvp6Bzhck=;
 b=JxqS+5Tq76K3MasFUD9UBMGc43Sfb9AO1WfqKZwHhN1VX0gMhPpmmxGrfroUWTzIIk
 p1WaU7O0nmX9a6dfwVYp5X3g5cMrIkIbqA1PXVuZUPMaWMi5gO7qJm7uGCihMw2dKqiD
 UW1L+90HLI0TGVTHxonrAPyfsU9FR8tTm4km3ttfx+8RJ+tvuUJ8GZ+iyUeq7UYg0ThS
 KFAIqV6lHhNdjGEDvH0xc4ddYyaiJmJi4MxsIPelonEcACUu0fKZKkPhV0DWPdLCJ4DC
 WPAeJTJfSIlX+a5rpyOe//oS8RLf+2J0qD0KbAjU/tOlUnP3ywWqMpT3ZNW/ZWXZZg3E
 /iEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715104592; x=1715709392;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ive3waDoK8gwDGEBUE2bkX5N+SnSEytp7ihvp6Bzhck=;
 b=wXCrDF+X6TisMFyhjdqesHmDZ74bnBuAhPzH34zwUekFrbtXTcDOKFkeTfs9wCx0i5
 5/xFU2yJBjYumHGvuOiVG8DBuqJESAq7uLJM5gnswPuUY/JrQS3zkpGKIS895jmX9vuZ
 H9ZaOxSP0+ZokpDpmys12pbHUmQDGrF/Gqx5zYJ9aYks7+3uRveK75DFRxHV2+7o47Ef
 SJlI2ca6qI4+FT9jV516ygXuKFUWXYhbPIrNrTyTAeQxLPCUO8xvWWVLHLYDEcS3cG8t
 VKn1SI4R+pjs52NiK+RC6KwQKotXynR9rGqxJjFMIksG09/Ldu305jxYxnDIaG2a+67n
 gnXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwQjk3gBlRg86831o22tgQtfbvlH4Yn5vIwi/PgkaFjNhrSUxfePaiKkyhlmSrCrmT1s6rtIS4KxIgy3VArhBUSWosC3QAJO8HTR939uLH3YtAS5rr4w==
X-Gm-Message-State: AOJu0YxPHUv9EEupGz74SXnoO5iu4Rm2/9cUoqGSH0Id+prHWHKJXifU
 /iYnVjNKXcYEtzEIXe6FXjGDBSIYGc+2CW/mOYNxq6XgQdwKP/zvX9d7LQ==
X-Google-Smtp-Source: AGHT+IEjfRxzUs2wpGVAcI782dPodkBNSPfsWEd5VtY3GAR+bB9Wpak17hBN3oRvPuKogBnyQFbt9Q==
X-Received: by 2002:a05:6a00:3a98:b0:6ea:d114:5ea1 with SMTP id
 d2e1a72fcca58-6f49c236254mr358654b3a.17.1715104592171; 
 Tue, 07 May 2024 10:56:32 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2620:0:1000:8411:1c98:67c4:cc33:3971])
 by smtp.gmail.com with ESMTPSA id
 fc16-20020a056a002e1000b006f4596a2753sm6269387pfb.40.2024.05.07.10.56.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 10:56:31 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Tue,  7 May 2024 10:56:28 -0700
Message-ID: <20240507175628.2460390-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
MIME-Version: 1.0
X-Headers-End: 1s4P3S-00061k-V3
Subject: [f2fs-dev] [PATCH] f2fs: allow dirty sections with zero valid block
 for checkpoint disabled
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

Following the semantic for dirty segments in checkpoint disabled mode,
apply the same rule to dirty sections.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/segment.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 6474b7338e81..2463398b243f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -771,8 +771,11 @@ static void __locate_dirty_segment(struct f2fs_sb_info *sbi, unsigned int segno,
 			block_t valid_blocks =
 				get_valid_blocks(sbi, segno, true);
 
-			f2fs_bug_on(sbi, unlikely(!valid_blocks ||
-					valid_blocks == CAP_BLKS_PER_SEC(sbi)));
+			if (!is_sbi_flag_set(sbi, SBI_CP_DISABLED))
+				f2fs_bug_on(sbi, unlikely(!valid_blocks));
+
+			f2fs_bug_on(sbi, unlikely(valid_blocks ==
+					CAP_BLKS_PER_SEC(sbi)));
 
 			if (!IS_CURSEC(sbi, secno))
 				set_bit(secno, dirty_i->dirty_secmap);
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
