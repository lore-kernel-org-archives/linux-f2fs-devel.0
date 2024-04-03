Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 764D7CD128D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  3 Apr 2024 07:52:36 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rrvQB-0003Vt-EX;
	Wed, 03 Apr 2024 07:52:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sweettea-kernel@dorminy.me>) id 1rrvQ9-0003V3-Lb
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 03 Apr 2024 07:52:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XYLdNTdp1sb8y0KkPRDqvXS9qqEnJ8BkdW8PboU2vUc=; b=AWWSy64q2nKj55zHKMr6fvnUh+
 vk+lL0jIrd1GgsFwBfl3GsJtGg2gNoV60XvTEj1RAmzBjWYEh1h9JTfWXpXomNjVoO0qTy2nRHerA
 9xwHRRXikMPl6xFFyHVtN3zKDa2zwkDRumT19oab34rc3H78Uto1w84St8i9C8Vp0cnQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XYLdNTdp1sb8y0KkPRDqvXS9qqEnJ8BkdW8PboU2vUc=; b=WrZFxOV3AI1Dk8/38tjuF+Te9G
 5Xk6WleaPX1BT4jx/OPLHsdD5ycsYKNgWMXpSbphrHjPJRQqhWhEA1SJcL9NfoA6ILfFVYyrYOa4y
 YgzpE56ZAm1+hsIXcOEgUS1kbOSgt1UTNO5yGl63XsfBGl5kbKzfRaElChWWID6TDTFQ=;
Received: from box.fidei.email ([71.19.144.250])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1rrvQ6-0001lz-68 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 03 Apr 2024 07:52:30 +0000
Received: from authenticated-user (box.fidei.email [71.19.144.250])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by box.fidei.email (Postfix) with ESMTPSA id 8F82180924;
 Wed,  3 Apr 2024 03:33:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=dorminy.me; s=mail;
 t=1712129621; bh=94RmlMFWXGTXstz1CwkJFfXxsHVZs+VkfOwiVdyhsCI=;
 h=From:To:Subject:Date:In-Reply-To:References:From;
 b=IbWMGL//ndu+2eM5w3j/YnRT3w418ByjraEMNZYb0TTbSS7WXFhnXQENWrVb6R3RT
 XMvJ7x98BSJoTIoS8dr5PsO4Q3LElCZuY78m99E9Yp1NGJB1wOQKKHDALrrTFFszkb
 cnahyGw/o5jSZ7OQvg9EkTVmKsJwqBtS8i21HzuewEZSc5qzEGZewbLAdc/pLE499q
 uoIvMReqQmd3Yp0ZzO3c82sWs2/d2DI/x1RrTza5ZzPWVj7wD7oZSxgtDD8T+bpuEE
 UlUzkevR3IuBxO03l5JyQ3zoKQv2YmlR7hVVtpSwtDxSbaPwVFFvKaiRejBSpexlW1
 eK1THOkEXxD0w==
To: Jonathan Corbet <corbet@lwn.net>,
 Kent Overstreet <kent.overstreet@linux.dev>,
 Brian Foster <bfoster@redhat.com>, Chris Mason <clm@fb.com>,
 Josef Bacik <josef@toxicpanda.com>, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 =?UTF-8?q?Micka=C3=ABl=20Sala=C3=BCn?= <mic@digikod.net>,
 Sweet Tea Dorminy <sweettea-kernel@dorminy.me>, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, kernel-team@meta.com
Date: Wed,  3 Apr 2024 03:22:53 -0400
Message-ID: <aed306393b3e90379ec2b2f66e5ab759cfd3363e.1712126039.git.sweettea-kernel@dorminy.me>
In-Reply-To: <cover.1712126039.git.sweettea-kernel@dorminy.me>
References: <cover.1712126039.git.sweettea-kernel@dorminy.me>
MIME-Version: 1.0
X-Headers-End: 1rrvQ6-0001lz-68
Subject: [f2fs-dev] [PATCH v3 12/13] f2fs: fiemap: emit new COMPRESSED state
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
From: Sweet Tea Dorminy via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Signed-off-by: Sweet Tea Dorminy <sweettea-kernel@dorminy.me>
---
 fs/f2fs/data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2a3625c10125..e999cb1bb02f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2014,6 +2014,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 
 		if (compr_cluster) {
 			flags = FIEMAP_EXTENT_ENCODED |
+			flags = FIEMAP_EXTENT_DATA_COMPRESSED |
 				FIEMAP_EXTENT_HAS_PHYS_LEN;
 			count_in_cluster += map.m_len;
 			if (count_in_cluster == cluster_size) {
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
