Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E92ACDB46F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 23 Jun 2026 12:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=y4YRWSJWpJ8ooJJTRVTwmKBlFdPIrOQxE6l5U41BT9w=; b=FuiUqHneu+u5LUx55i1naZ4zhm
	QRPelvr3F1mGl+jZessUI9Wg+oQ4NxGHGrvEHUWKoUdj6bGYC6IZfFV9cGuNE3WuVGBwOFzYMCL1X
	QTvL7MbvJYyr965bXZNS38HPPO7H3R+2dfTDO7UagHMQAAcMU+zjmlCvNF6D2snOMVBg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wc0YW-000645-4b;
	Tue, 23 Jun 2026 12:48:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wc0YV-00063u-5R
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 Jun 2026 12:48:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fh2xVkXogjEIRKLrvZqDiERD59pJO7yOkJYWwq8xXLQ=; b=UqfRVWWG5B0+snNpDUcx+qRoIY
 KOLw/vqTGnWqzSB2Efgjhs99WyGVP/cs4/pEhg6f32imXRywc9jh9W8Iz7bfvXVZwXJk4NP+TvWxG
 1rpw0d+llFy+eKmMtKuPOqtMG59mmqgA/+/DErfcD299IHxzUE1vofXVXqlxxMrsJxIg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=fh2xVkXogjEIRKLrvZqDiERD59pJO7yOkJYWwq8xXLQ=; b=j
 /j2GSY94z1LGQ4z+RmLR6ij2tWQ3gmate6F9h5RwsF8vGzL3EJ9vfYg0eO/Dm7Cbdf0xV5ir6s61+
 oL6b3ztCYPArEkj0a/H/egLbaai6pwgSHiIwPFjWhGq3622trf4XzaoFfJST/VjHFC+qWGILNQw2+
 KjwrJO3gaT7JRtuE=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wc0YU-0003HC-1g for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 Jun 2026 12:48:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E6345601F5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 23 Jun 2026 12:48:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FEB31F000E9;
 Tue, 23 Jun 2026 12:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782218911;
 bh=fh2xVkXogjEIRKLrvZqDiERD59pJO7yOkJYWwq8xXLQ=;
 h=From:To:Cc:Subject:Date;
 b=kDRUmCzsNrg9wcUgdjdEYMjmZvGKeN6NuTqIa7mFF9flGdTjUaf5WAuzTZKUT/tOO
 jofEOu+GAEjp642g5H1mv2Gi0fkDodbSHbgr5HCtkBpithnIGhcP+JQl4aw6/zOEVz
 eKeBZmU+hQgAkG++MM4EJgiBc/GAzqpvqVj9Egp+OYqZK8x4Fj5iSIbqMdvADSkXZm
 ByqFcjjJcGACxKnSOqFPAq7hTsS8TatjbhhMvRgdf2/JBqrwT9TqCuR4o6olBJojRW
 Vo9F0JblPlSDCVBuf31XxXz6/hABXTGc4OFJQ47dymHt7vNOy7/dFFK01afPeZZNxS
 4u8QXtVrsnAQg==
To: jaegeuk@kernel.org
Date: Tue, 23 Jun 2026 20:48:23 +0800
Message-ID: <20260623124823.1674416-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.rc0.786.g65d90a0328-goog
MIME-Version: 1.0
X-Headers-End: 1wc0YU-0003HC-1g
Subject: [f2fs-dev] [PATCH] f2fs: fix to avoid move_range and defragment on
 device_alias file
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: stable@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

It's forbidden to migrate blocks of device alias file.

Cc: stable@kernel.org
Fixes: 128d333f0dff ("f2fs: introduce device aliasing file")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 4b52c56d71f0..f4facd409d9b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3083,6 +3083,9 @@ static int f2fs_ioc_defragment(struct file *filp, unsigned long arg)
 	if (f2fs_readonly(sbi->sb))
 		return -EROFS;
 
+	if (IS_DEVICE_ALIASING(inode))
+		return -EOPNOTSUPP;
+
 	if (copy_from_user(&range, (struct f2fs_defragment __user *)arg,
 							sizeof(range)))
 		return -EFAULT;
@@ -3135,7 +3138,8 @@ static int f2fs_move_file_range(struct file *file_in, loff_t pos_in,
 	if (!S_ISREG(src->i_mode) || !S_ISREG(dst->i_mode))
 		return -EINVAL;
 
-	if (IS_ENCRYPTED(src) || IS_ENCRYPTED(dst))
+	if (IS_ENCRYPTED(src) || IS_ENCRYPTED(dst) ||
+		IS_DEVICE_ALIASING(src) || IS_DEVICE_ALIASING(dst))
 		return -EOPNOTSUPP;
 
 	if (pos_out < 0 || pos_in < 0)
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
