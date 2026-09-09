Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65A50C79FAD
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XRrB+1C+lBPsZIFpjiDw5I9GhAU8/17Bk0Vg2lJF/ZU=; b=G5MCX5IAU1daljGZdZJ31GVQxU
	uFwHkmfuRlsiLYELLm8XnFAvSBEG1e/ny+whVLDB40/9zuRKDNRUG13LqtvJxKKGjM4Mj5NPCqNT4
	QnJRgZIodRBUHmu+HWg66XQsIXzkNEDRy27A3gQtD4UX7rcNKGJABqk5Wbvt70FHunFg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4GlG-0000MG-Ts;
	Wed, 09 Sep 2026 11:46:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jnhuang95@gmail.com>) id 1x4Gl2-0000L6-1K
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 11:46:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FzPGH/onlDkeao3FKtNRGyfogFTCwrFBw7yRpYpNoZw=; b=Nu/hPbQ9+WujKnEdMnn98MMbsj
 h/9CFPWHnyQ3uH6F9NuPnsnuvIcRowmvjqHXP8XT1OkpD64EVf0XodmMawrncHaCuvW9b5uHGb8tj
 bIrCMl/KObYJsx9PGqkwiE35aneQlTMrGXgTvB7Cm7QAfvTVJdW0qJXpJ0dbZCfo1V+o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FzPGH/onlDkeao3FKtNRGyfogFTCwrFBw7yRpYpNoZw=; b=V
 DhS/o0ofcnTbxzj4Z1vy1ByQkoj5ghn0BdbRRRRpuD3qecExbLYZV3k5mip3yhrHa6wnvAagPpXMl
 Sg1cqZbbO7oDKjof23GwHk0TzI/l+6GQkg+fC05Zkavu8fr9//MLLVIe94rgf2KaX2SeGLi+prwJC
 8DB8MW2InKTwyiok=;
Received: from mail-pg1-f171.google.com ([209.85.215.171])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4Gl0-0000rj-Oh for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 11:46:28 +0000
Received: by mail-pg1-f171.google.com with SMTP id
 41be03b00d2f7-cc1c9879395so3781689a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 09 Sep 2026 04:46:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788954381; x=1789559181; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FzPGH/onlDkeao3FKtNRGyfogFTCwrFBw7yRpYpNoZw=;
 b=J0Gqw4Pii2IEsOpcnAbFkfhdqRb+wI19eIrJxfxvdu1Uv02sTyB+XdFxol6m2zrywD
 n6/UkvXWxPWSDWVb4C8BHVCV5FYOGKNco/gMh8OkEe/qRed4Nlz1Ao0qQoAXUUB3zl7b
 CWISwhYTQYomEL+jHuL5zW1cRhDRmwnPb7k2xvsctTzQhVnHof0x8n9nGw3y9VFLr7IX
 UTEAuNDoOGAl4n2DvZ2/RZfoDIcrtBCAj0QsBz40R/NiF+jqOhK5SVD9rrVRSib9XDGk
 xMoRe0n1xXPMR44hoo3BPOu2QcvwNvZe1MwU7Z6QJb7K7sVyfRTrIqVcayb0xlsXheyj
 kWBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788954381; x=1789559181;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FzPGH/onlDkeao3FKtNRGyfogFTCwrFBw7yRpYpNoZw=;
 b=l5cnxnhUCFgh0TMAQUS1ljfi/YV3RtiB+hT2IjHY26s7vulhtLkIGOWRv6/cRFE4AS
 IsRYe0TaSXcaday8jFMCnEJx7tahftMTyb8U8v6HhEakcXD8A/Tid4BImFBkmhAodGq4
 vLPlaYhT6iAq2z0ozgbepL+aRd/lKBzCQbZbXYYnQXNs3TA5OiVrYvg5Y8/shQB6ls8O
 EmQY9vRolS8Fsk+AmqUihBI1AsIuG+82smeTH05p7G643H1IDbu+71LF4G5Fb25pOtoK
 cOf54sMH3z65hdLExGBznHYKlOEKPxEhzbJfA3pz3aL4DBZKwCaghZzd6lKFQz/Ab/ze
 QM8A==
X-Gm-Message-State: AFuF++mC6e/a+ymWahPu2Q/nonE/YDGLJK67gBy8oqfUhBsCyKXnKxRL
 VRqmFOkSUDqaEHuGCfFUXExaXqk3oBcG7Q19qR7xXBxVVo0rgtIzWidHsPITbQSfUpc=
X-Gm-Gg: AYBFou0btgvKdreueqIaQmVGaadjW/GqqIBfygcmAf0f0qn7/j2tUmRQk9PV5KaQTl4
 WpU7Vygj524B/ao2gBHwQZIc85+j6kn8dvL311nAwGNm/oN0Ub5nLsv1ODMvon/T7CUC60a3D6G
 C24wv8rnWEtokbcFvuwW/E5p3s1ATI9KWKlvrr7aelveZ9mjg4N/0tKq1AK5EU4sEwespMaV4Hw
 x/Tmh4YqdAL/EwucxSQOM1phfgW+d9BCxgR/ky71KEwAXSE0sPyAVvXjnrUzxoFYR45ibLQ4D9O
 S2quPQy6JvmAX1zw4fzA604UD+jJcOA/2TbaHaTDcXXWSx5X0oXfmqYUw6l/DhBA6VCf93P9z2+
 4SuZKAUc4kDTm1S+1GhtsdHnK+vcP7ErnHkGG8RmeD9laWmzxADtPKnh2s/1Yx8FvoeMz5WTmIY
 W0jnqrvIAx1WVq1Iek7GNequ5BOijlvnIePZlHrvLIz28M260xCg61uu+ZBstRPbXTOw7f6gNd+
 UHKD/voEJkMBds1t5c/xfh4lgRWf1z1GddX+w==
X-Received: by 2002:a17:90b:2b4e:b0:38c:a59b:5189 with SMTP id
 98e67ed59e1d1-39b261d0d8emr53709922a91.15.1788954380841; 
 Wed, 09 Sep 2026 04:46:20 -0700 (PDT)
Received: from 4ce604c9y2.bytedance.net ([61.213.176.56])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b260cd15asm32355971a91.4.2026.09.09.04.46.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2026 04:46:19 -0700 (PDT)
From: Jianan Huang <jnhuang95@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, chao@kernel.org, jaegeuk@kernel.org
Date: Wed,  9 Sep 2026 19:46:14 +0800
Message-ID: <20260909114615.1390443-1-jnhuang95@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1x4Gl0-0000rj-Oh
Subject: [f2fs-dev] [PATCH v2] f2fs: quota: fix stale lock holder on remount
 failure
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
Cc: Jianan Huang <jnhuang95@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

F2FS remount can fail while duplicating a journalled quota file name.

f2fs_remount()
- sbi->umount_lock_holder = current
- kstrdup(F2FS_OPTION(sbi).s_qf_names[i])
  : fails
- free previously duplicated names
- return -ENOMEM

The direct return leaves umount_lock_holder pointing at the failed
remount context.  A later checkpoint may then wrongly treat another
context as the s_umount lock holder.

Add a restore_holder cleanup path and use it before returning -ENOMEM.

Fixes: eb85c2410d6f ("f2fs: quota: fix to avoid warning in dquot_writeback_dquots()")
Signed-off-by: Jianan Huang <jnhuang95@gmail.com>
---
Changes since v1:
- add restore_holder cleanup label.

 fs/f2fs/super.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 1314b6ccced9..867c82192078 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2864,7 +2864,8 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 			if (!org_mount_opt.s_qf_names[i]) {
 				for (j = 0; j < i; j++)
 					kfree(org_mount_opt.s_qf_names[j]);
-				return -ENOMEM;
+				err = -ENOMEM;
+				goto restore_holder;
 			}
 		} else {
 			org_mount_opt.s_qf_names[i] = NULL;
@@ -3125,6 +3126,7 @@ static int __f2fs_remount(struct fs_context *fc, struct super_block *sb)
 	sbi->mount_opt = org_mount_opt;
 	sb->s_flags = old_sb_flags;
 
+restore_holder:
 	sbi->umount_lock_holder = NULL;
 	return err;
 }
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
