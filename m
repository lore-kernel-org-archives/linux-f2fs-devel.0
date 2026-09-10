Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E869C88E41
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Sep 2026 22:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Date:MIME-Version:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=gWiwa0uoYhF4om9LeOwtwhYBczPJERbYD9KHZ4ds8yw=; b=HI8p2Pvftvz8kXlVUmMEJxaU+i
	lYibf4Y1UVVmg4NMrouZDJBZkLChL+bZHB1UoK8OVjdO8Mvll9BVoiL2ozUU6eGTPkvTrOLBucUQt
	Ykbt2+tFxuzLBJdax5t3Z0ysXNjs58/ZLghGDXkEJ/Ln9llSGHcfC5uv0STtCoiGtWxs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4n1o-0001Li-0Y;
	Thu, 10 Sep 2026 22:13:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <farhad.alemi@berkeley.edu>) id 1x4n1m-0001Lc-Ny
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 22:13:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:
 MIME-Version:From:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Dl/lrjIBKTQVv+jOBrTw+8RbI9HTEQP7bOs7FBwNKco=; b=SQyRoencj1UNSBUYxqMo+FQq3f
 z5amIyQgfiyG5JOunt5Vz50mfvzTYR0LoWhmcVIeRTgwu79m8yxlvFg1bnA/H3ygF5qkqHnKErVm+
 E0cZQsPwXRv2hS/yd6aXBQAzGeNSPdOYevU9QNxS3BIDx2IgpiHGJIeUvpbHG2QIJo7k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:MIME-Version:From:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Dl/lrjIBKTQVv+jOBrTw+8RbI9HTEQP7bOs7FBwNKco=; b=d
 +aHd0gOEcQQHw9erfc8sJnz5JMCwbZjh58nzfXHoKeckxDzOFqQHWksAzF+LkXAsG9Il1sB7IO/5A
 V8XwogwVHfHN0d6MXKUvxNNDBOtVJ6oMmNlB9sGqXqD0o2srJbvC4YCI0IlkJDwOo3cWFrLRQ+vOQ
 WrDvM3TZdZt4QnOU=;
Received: from mail-qk2-f12.google.com ([74.125.230.204])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x4n1l-0007BN-Ah for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 22:13:54 +0000
Received: by mail-qk2-f12.google.com with SMTP id
 d75a77b69052e-52fb76ef1d1so4776261cf.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 10 Sep 2026 15:13:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789078427; cv=none;
 d=google.com; s=arc-20260327;
 b=keXX/C3HlCV3S5s8WOceff8kkTcYEb6jLGqqv7o0p1J8Hdb+0UzW5DU7kYoce2dEo1
 KsppYj8pMjhJBfKb3T5NThRrbGL+CRnpWGVux9mHHWOz7NAUSslXWmX/dBFcjL6VQ/LT
 E8GYaYF59llwGR2PyNMUYLpMkln836ykup9IEJgjVmd7vFk/oFg7/tZxqgUnA5lSP5vF
 2xh+OqAuWaOnGdYljjWscg+1uzehCF11pWc7VgZbnVAGWgTuZySV9uvBpKzTofnF6Ipv
 1JwKrJD2DxaIwnS4E5JR8/m3CYSMwWehovuITmtmVBsjPNGCumX8ByaT2DKJJhoeS9+7
 DcAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
 bh=Dl/lrjIBKTQVv+jOBrTw+8RbI9HTEQP7bOs7FBwNKco=;
 fh=lQO1pkm9ENSEWo/+jImcwYbK/2YodA5annDl00uwZyM=;
 b=bBiY62bMTtOCfmRB9dMzTl/QwUAheC+HLDMjzkhjEmmio1F+fUBaKFQaL1uTglwagJ
 unXL4SuxNW3LK32AYJOurLyeoJJH39n4E/83Eqp4JAAeq6Qrqvt+sR1UyXpX6JkqEe6z
 vdbhu8Htiun77Iwu5IAQKWAn6ZI7e9dQZnDsSmmAf4lIXJPGe4lafvqm4MrQ/jmpz4Yg
 Y38ZE6nlZF3sW3RU+FCgoKeUSXrjK1Zo7yhm16ILcZqIplmG4ncbG/IoERbE/x5pkafJ
 gwlBpX8yWeiZtmyqFrcJT5Pr/0XzW8TSzpi66p/XblzbIkTOihhjGrEzTQa0f8Tur1M2
 yQyA==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=berkeley.edu; s=google; t=1789078427; x=1789683227;
 darn=lists.sourceforge.net; 
 h=content-type:cc:to:subject:message-id:date:mime-version:from:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Dl/lrjIBKTQVv+jOBrTw+8RbI9HTEQP7bOs7FBwNKco=;
 b=fohQTuQ3gUyipHHPklElHI9caLYH8FYPyIj71dJPT8xYVAYwuTk8HJ8zQawvxYLvgA
 HAcY8S8u3KxcXrv5TPRheM0EndGK7nYS7qjoygRl7RPTZaKBTk2hiOUurRfU5fAHBcWM
 i+Rwb1v5arMvDMyAjBvEydkxsgOXOXwOYgCcrZ5XqPF8TGTfODjmAM4BZfz/+Uuwqcog
 Pvdr1e6+j9uY19HiNkheub7k/G+G/sz/v02AJAX5M/87A42mP3Lkdxyh5XKDQO5egZut
 lzFsY3AF7osDC2oIbyktrZo68iuH8OD/zG+n/dqKDh1+uNiDYQbFG3PgbgvH/S4//PEf
 PLUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789078427; x=1789683227;
 h=content-type:cc:to:subject:message-id:date:mime-version:from
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=Dl/lrjIBKTQVv+jOBrTw+8RbI9HTEQP7bOs7FBwNKco=;
 b=JLar6JEg01UN1T7jYFLkowYwki9H3pz8S7X3okMArkIC5w0w6oDROOTUx0Hal11vjU
 SWO5JYtM7xA+tTJYVIhGxz1u/Z1BeRpmZRgZ43nd/gzq1E8KRVdjX6qrZ9Ux3sBMngWa
 vuCNBUs9aPIztbOXUFHwjzMmqjxbmVv46MPvxQGMBur1+XBUDc55t37nqOm+vNrIimVu
 DezRpdxm5KoZJBLEdYRktf5fz62sXUN453m2vIqHMpX1UEzV1EBzyklrXvDHG+EVbMaf
 0Y0OVghUqIl7TF+yFxi0qriI2SKcKmaTVPgCuCC3ZFyAYvP1SrxtYjeEcEuJNIquCEww
 9QUg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4mBxQK/Yz07CbO8e0W/tNbafGs6MYa8g3TqGqpJZIXCTJItvgM1q6fEal/qseQmqv4QSZiZApzTlk3mQyiMwR@lists.sourceforge.net
X-Gm-Message-State: AFuF++k4euoKeCnqYDVlwDzKW4RPpwg1/M4TmhRMM7VL+zuBZAaP5umU
 FhbhH04u20vQ/TP/NvFPT+atDmY2Sm2sfbijmkVWh7Q0D5CBrgkSmMO5gidrOGi8ZPWosWldOU0
 saBCgy05rVPc8LypUzJ38grZ7DfTtyVrtTkgAkaOCQDnfqG0VU5azNQ==
X-Gm-Gg: AYBFou3swOme8Gwt/AgHp54SEmC/Y3GGshnlr76LUxK74luiXZO7kA5AWrSFI3wdZwM
 SJMre1jTv1UT07Zf4T9KBGUKm8tNuWzVOsynuSNUHOfG6rZ7wuAXvV4t7b8gEF8cdMfn8JB78tI
 H6DYTLlrrUdgxlq8fZZOCfgIWJni6d+SJrtFdOWaVCdbSBzUpjgV0rogclDzcebZnLKcyY5+ITy
 CK/rXQLZ7nEyBS3LWuv8zI3BWd2xl9dQgxH+KFNwChBvGexMnIAWm/zQEG0NEThGMRoW17ZrVmK
 JatKKVZWsjL4aIsikng9QtdKqC/zoZ0gAtUof7eNB2MdO3TaoDVzzZjHmpM1pc9Sv9Mi/+ktoyR
 HXYoU5BvVxnkkhC1/j2N0QKQYdp1MBO6tswmj11uLobc=
X-Received: by 2002:a05:6a00:c4c4:b0:869:427:9b0b with SMTP id
 d2e1a72fcca58-86b30e0c7f7mr1052490b3a.1.1789076842087; Thu, 10 Sep 2026
 14:47:22 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 21:47:21 +0000
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 21:47:21 +0000
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 21:47:21 +0000
X-Gm-Features: AcwNN1UuNgE93mQmrT5ODw4YWg2HNZ_hxuHKP9cOZHTw5nScsf2TNLiEOtPKodE
Message-ID: <CA+0ovChT6BRXp0kntaJ_Eiw-2-z=fpofsvyALiwdORe3zG_YWA@mail.gmail.com>
To: Mark Fasheh <mark@fasheh.com>, Joel Becker <jlbec@evilplan.org>, 
 Joseph Qi <joseph.qi@linux.alibaba.com>
X-Headers-End: 1x4n1l-0007BN-Ah
Subject: [f2fs-dev] [PATCH] ocfs2: don't let the root inode outlive a failed
 mount
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
From: Farhad Alemi via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Farhad Alemi <farhad.alemi@berkeley.edu>
Cc: Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, ocfs2-devel@lists.linux.dev,
 Alexander Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-fsdevel@vger.kernel.org, falemi@asu.edu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

ocfs2_init_global_system_inodes() installs osb->root_inode before the
second ocfs2_iget() runs, and when that iget fails ocfs2_initialize_super()
jumps to out_dlm_out, which sits below out_system_inodes, so
ocfs2_release_system_inodes() never runs and the kfree(osb) that follows
makes the stranded root inode reference unreachable.  ocfs2_fill_super()
strands the same inode a second way: nothing drops the reference igrab()
takes on osb->root_inode when an out_dismount path ahead of d_make_root()
is taken, so the ocfs2_release_system_inodes() call inside
ocfs2_dismount_volume() cannot free it and the root inode stays hashed on a
superblock whose ocfs2_super has already been freed.  The reported KASAN
slab-use-after-free write hits an ocfs2_inode_cache object that
ocfs2_release_system_inodes() freed during teardown, so an ocfs2 inode
reference that survives that call is a lifetime error on those same objects
and not a bare leak.  Release the system inodes at that failing
ocfs2_iget() and drop the igrab() reference on out_dismount, clearing inode
right after d_make_root(), which consumes it on success and on failure
alike, so it cannot be dropped twice.

Closes: https://lore.kernel.org/all/CA+0ovCjAKQMn7iF8BJR-3+G9_HBRnRFtJxjr-9P9GuKSxFj+3Q@mail.gmail.com/
Signed-off-by: Farhad Alemi <farhad.alemi@berkeley.edu>
---
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -450,6 +450,7 @@ static int ocfs2_init_global_system_inodes(struct
ocfs2_super *osb)
 	if (IS_ERR(new)) {
 		status = PTR_ERR(new);
 		mlog_errno(status);
+		ocfs2_release_system_inodes(osb);
 		goto bail;
 	}
 	osb->sys_root_inode = new;
@@ -1110,6 +1111,8 @@ static int ocfs2_fill_super(struct super_block
*sb, struct fs_context *fc)
 	}

 	root = d_make_root(inode);
+	/* d_make_root() consumed our reference, on success and on failure. */
+	inode = NULL;
 	if (!root) {
 		status = -ENOMEM;
 		goto out_dismount;
@@ -1163,6 +1166,7 @@ out_dismount:
 	atomic_set(&osb->vol_state, VOLUME_DISABLED);
 	wake_up(&osb->osb_mount_event);
 	ocfs2_free_replay_slots(osb);
+	iput(inode);
 	ocfs2_dismount_volume(sb, 1);
 	goto out;


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
