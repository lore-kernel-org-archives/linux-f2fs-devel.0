Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164E7C624A4
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=izXOwOdRBElM1vlgOYrsX5tpHq41VWT1lG3Jb3wCaoc=; b=FkkBWJPo2+h7HIIlOyoH9zoKcU
	ytGNmQsY4z+EqYOOMV/b86N8UlKdu2ki/Fjfxw65r6u5QMdpZ4XAbDhzD/gA51VzMiXb0pXGFPMve
	1I1GNaYUslCe1NMyoWYi1UiqAXpOcoAj5TAs35GMwGA/PLLArjtFXyMhfQ6ivoSV8q/s=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x12ET-0003l6-FF;
	Mon, 31 Aug 2026 13:39:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1x12ES-0003kz-2D
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 13:39:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sZucnVJNR3hl6h09dKjZV+Hmp15h2B10GaDWcNF5eeE=; b=OzAXDyN1RmNZLAHgNXQq9npNhP
 EfXRmd/cjYpQrRwvBqqnsO3/SZrwM9X3j8bx5Ogt1Zc4T2XwqKOlO6Mgcmy8W/x+Zr+ZL+nJbrdoX
 4r8jAg0/bl0wFd4KJZTcvIpmOxqkkPBq6h8VEn/OoGw9Y++BmwEJXJELB+/BFbQ6OIAE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sZucnVJNR3hl6h09dKjZV+Hmp15h2B10GaDWcNF5eeE=; b=G
 Su2kqnOso2YwLjzhCqBb+OP4RU55rrOxz25CxE/UQxDaBtIpFnYqxFnfNrLXFTmeboRONwLAS8u1y
 3hRkpCaY0dCdVj0PerAdC4lMwSCNavNq+uezWB6W+JmMIerhfACWpCGg4DCX4Rugu9DLyVjFszjs8
 DgPFiUZSSQ1o9Yww=;
Received: from mail-pl1-f177.google.com ([209.85.214.177])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x12ES-0003ZH-D0 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Aug 2026 13:39:28 +0000
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2d715f4a587so49980355ad.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 31 Aug 2026 06:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788183563; x=1788788363; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=sZucnVJNR3hl6h09dKjZV+Hmp15h2B10GaDWcNF5eeE=;
 b=I4+XyZMAz5eV0IpyrSSx/TO+CHqttc16qnyiFjuDDDuBY8b9aCjTcSTfbF9fwgRr6N
 5h/lb5JbDTjtJLVCo2a7Qdf2qw1i0oCJHToqn550Fq/C/Akdsh30uiBBrOOzqvKUfsCc
 QeXAzAEibidjebpjHdhLUteWk+zJCkqGnGBb4ay0CVl4sTSBXDZR78+jnU8NdIcrDW4d
 vedRRtlLaOYG0mvMGoDXtW8TviaNllmAN8YhWc+h28yFZgPMvOvB0lkYgSOHG4+RIT7x
 ZHbJk9ngqHodfZso8qKJPWiw75tO7Etq3nabH6KfIobo0h4/VErDEraWcHByek7VsW1H
 VuiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788183563; x=1788788363;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=sZucnVJNR3hl6h09dKjZV+Hmp15h2B10GaDWcNF5eeE=;
 b=nnYceho2mA3TZmYH+RCz2Pf2YPRiD8CX5LHqhdYyGnUPNSF84jpewle+GfSbiIEaZp
 x+EmvzJLoFBztxhdX4y1AKx3Y1uljM9+dyYGS79nI9zYvymAez+VatqF7q5uUgONG2cV
 wO/pGBSf2MdsdKbVlMzlDR9KtXWrsB8+xEfE7nZfnXZ0MVIsk7IyMwuLU2DyWsI5NtrE
 ob4qqIvuY76bKeF6wLu5XaQWlqAbPwNrjseCjp0QpyAA1AAJFlgReSTfzKU6zIA+mgy+
 dIdIosRiDuW3zMVbYZV8AhWThe2fsL/BMBw91EfZbqBnoeBaLpcmfBdKii+HTaxerUsr
 TnWQ==
X-Gm-Message-State: AFuF++krmj+LiYQNtvMsKp+c110Vf+r0apPXg5GyF0hwl5tmCmB1t6pz
 wHqqYfnOvDi8itupLfsVlzlBUNkSfVunNbShv258R/H1xYa0vCxNbTfi
X-Gm-Gg: AYBFou0o1jCS8+YJn2Hv9epU5Qe8hGmVm63+QfoNGdkXgVJsMHhtSLh9nGIT42xhivb
 fXGOuWvOaBE23HkO94SP/LTiIsSy+HvRhQwflFkBC5sn8G9ZIyHBkHWWAXhrULk8DcCvZVqARGN
 t1GG1LYX5GmC+V6WIYj3AZM/16pBmbORfWiZb7aTb8s8yVFGBR5kAxY+v8iNbONJVrg7yh32DUy
 7HCsqpdinJM6E1LlgRpMnF/IcfBTaMnw4dmZjg8DARfmDOZ70FWcpvlBK0vv7czSNGJGhXxjtGO
 eAuQsLawiyBtaojEyyXoeEJXvNkCCmjea60RLHethH8z65E2UKqFoA1WD2pd29Xi4mLPXcFWdMl
 gKhLaRqYxlNanM06z84d21pAsHHxYlQ37YAr09Q5dh7Pg+cDeKnQZ06Ce+eKe4uAgB2tseVkrmy
 57h8Ffc0yWsX/j2Uqyig3ISs6rcKMkPuPAcXQ2fjQICiaW69D0mSDt+6PiliVV9ely6CDmUNC/f
 n2jPEP7j8Mqy02m46G1MMjf
X-Received: by 2002:a17:90b:5102:b0:38e:70d5:b12d with SMTP id
 98e67ed59e1d1-396d0ea862fmr43416157a91.6.1788183562538; 
 Mon, 31 Aug 2026 06:39:22 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-398c3a10e6esm10538247a91.13.2026.08.31.06.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Aug 2026 06:39:21 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Mon, 31 Aug 2026 21:39:16 +0800
Message-ID: <20260831133916.2110470-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1x12ES-0003ZH-D0
Subject: [f2fs-dev] [PATCH] f2fs: wait for inode record work before clearing
 ino bitmaps
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
Cc: qwjhust@gmail.com, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

APPEND/UPDATE inode state recording was moved to the inode eviction
workqueue. These entries were later converted to bitmap values stored in
XArrays, but the workqueue drain was left behind in the list cleanup loop
where it is now a no-op.

During unmount, inode eviction work can therefore remain queued when
f2fs_release_ino_entry() destroys the bitmap XArrays. A delayed worker can
repopulate them before the workqueue is finally destroyed, leaking newly
allocated XArray nodes when the F2FS superblock is freed.

Wait for APPEND/UPDATE inode record work before destroying each bitmap
XArray, restoring the required ordering.

Fixes: 9a9ee7408a1f ("f2fs: reduce memory footprint of ino management")
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
 fs/f2fs/checkpoint.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 4b59f30ef45d..400eab730c14 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -902,6 +902,8 @@ void f2fs_release_ino_entry(struct f2fs_sb_info *sbi, bool all)
 	for (i = APPEND_INO; i < MAX_INO_ENTRY; i++) {
 		struct inode_management *im = &sbi->im[i];
 
+		f2fs_wait_for_inode_record(sbi, i);
+
 		spin_lock(&im->ino_lock);
 		xa_destroy(&im->ino_root);
 		spin_unlock(&im->ino_lock);


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
