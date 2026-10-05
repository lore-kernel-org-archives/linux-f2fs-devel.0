Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEE6CA5FFE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 Oct 2026 15:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DeUUXev0o68b48tqvAqXGl/6j/5Crv89VaShWVLoRUA=; b=ADl2atVefXCjMKNcvEex7icCk6
	vdGe0b5znk46ys2NF4tPEAR57OBpJ6FlE2IwoetTfZ7xbXHsiJcBkQ+0ieZyWCup8MiXMpZmSpgCh
	6acaSzSsHOCmxVBfqYBco2K6NY1CpeQeI5vOgu2r1yFl2d9o5FBLkGU+nFDj/PmQlTkE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xDkxM-0004zQ-H5;
	Mon, 05 Oct 2026 15:50:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zhanxusheng1024@gmail.com>) id 1xDkx8-0004z9-F7
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 15:50:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t/MEt8ox8UMec1YG4VRL7RRNUQZVW+IA9Yj7RDmYjWI=; b=guA0eDyvwPj/ENIYkr1kkPxcQe
 xzVZ6UGxJ1/xCCEWzEA/YrPaLX1IC3Xxw139AzXzB9sMMoTnI5t1fPpqJzyDGVYdtiDPwpUMgsunQ
 dpkPGs9u8oU3ErJIRflmXQGPPuyeMa4DOKh0+TFAhTwFmWksYr95hF+ZwExq5UUsIRMw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=t/MEt8ox8UMec1YG4VRL7RRNUQZVW+IA9Yj7RDmYjWI=; b=l
 WwTIc44BZdnIioadisUwMiePuF+eKDyewRqqGA1KdTSK/aRRynzChyXBvJJwG5ecfk7tQ+xzZymJp
 t8f9jSQUncGRbSZIUk+31mOw4kiOChB6Tcegs8kfJIoSEJvnojrqjK5aAebRxIGlmZoG59pTj35Ov
 ploE+m7EWSlWA5PQ=;
Received: from mail-pj2-f41.google.com ([74.125.227.169])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xDkx5-00036J-Hh for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Oct 2026 15:50:07 +0000
Received: by mail-pj2-f41.google.com with SMTP id
 98e67ed59e1d1-3a6df9494e5so539217a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 05 Oct 2026 08:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791215402; x=1791820202; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=t/MEt8ox8UMec1YG4VRL7RRNUQZVW+IA9Yj7RDmYjWI=;
 b=Ss5C/5q6nByGVVZ5d4LYa78KpqsZ2hazeI2/GgF497Q/m6szKvpwMeMV8YLUbj8n/z
 ktKc8GzcxZDyNK1WSZB7DDfTlDfhNpjWkgce6EAmbufSt6xB4GnNfqqDbIpphqcQLrj0
 EI+VT35SsXQL5fCV7E4fwtX/kUuoiWCBzW/ChEXzec3hgIs2SmnTnkcwSyvdGpIBrVcs
 BEZHoPYw6jZFCzgHJjrurZ3lrnAo56n8pG5Ti6BBjhYa1u6qa46FdsQYlqeEuEgK4ubJ
 ocQGu4xTAiXfEmL+l994d+2oDl23DtkKonLRQMDokZCbKbcs3oxE62PsDAzAdbPrjJpv
 dmXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791215402; x=1791820202;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t/MEt8ox8UMec1YG4VRL7RRNUQZVW+IA9Yj7RDmYjWI=;
 b=jBO5StibBy2A9jYKAMj/vEi+b6josF6jSXgVyrXnYyjQUVKgvbQRS6zAlAjRVC1MWV
 AJQHAbZlT1jLpJNIK55tuXDf6NLwCpYcHtRfqFNAD0S3nqV7cwX76f7fR59VEfEG+34o
 Zev1zLRQiGrtDdvukh/OfrYfWScvUwJFrZiqyJdXilhKF3gwTEEBTnuPYnS1rdTmYFZA
 gLIreKW7+4MdP9CwD74xVaI4nhCgXpp0ry9aVwN+QOR4dDBj6NIy5yehFXccNvqwHK7G
 zW0jGUToKWJ18TCkacjG+0uAKhpJQFgxN5OGhpB6na+X54n17G316FAjwGiOB9w2JD/b
 ijrQ==
X-Gm-Message-State: AFq9FYLFpyVBm8iVMeqx2hWE8DIXyXDbewDEH04YBgbPdPcV98e7Zftk
 FzecXGE8iCndoD2j8EanGJav5Nir/IPFNPqKg2yUqeR0okJ8KQ+S0Mic
X-Gm-Gg: AYBFou2oZvg/gCdjGpWeBkDcFxxfFfMwK1niHXh0KwA+k2teV4PbYm7uxPJ3eO/BIe8
 xm1i+g1bBaPlqy/IUzfFwsuPfrAig7AkIRVD7J2XNbNruG60/r1H1GAcp+pT1o1OUK4Zw12jCne
 u3jnzgyyiwo2sagjrE/e7UuhfJMjoF3daxhXt2vo5anOkUtNhC4xYbftrSccM9aCmeH8/HD90fv
 PPS8YCRgSzVO10urMtCJf1rAUvrN9AXzsTwOqtoS863FFjWUGJz2ky0znx/Ih1kEt5jELTOMbEC
 es9R9KWzajPkb/JWL2yt/3wqOXOioaI+TSjDvsr6bko24jcqYMHjCWCcL8kij/GgHyCGSbS5Mi3
 UpFRHeBljxTYARTF+DDQin8WYvDoxLhZUmzGiy/uuoXfyLeuoW4dvjxCg55eWGeRIxlEewPAUav
 X/a//zafZv74HsZRIqI8VZJ1+UDudWeIaozkMKTgu6e9ljngo7G1rMA6PVgwce3gP+1HYPo3TKd
 a4ITNaZx87jXG1yr3XMRg==
X-Received: by 2002:a17:90a:c88b:b0:3a4:930e:6c35 with SMTP id
 98e67ed59e1d1-3a853cdb44bmr28181a91.4.1791215401795; 
 Mon, 05 Oct 2026 08:50:01 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a853ce2b46sm47748a91.14.2026.10.05.08.49.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Oct 2026 08:50:01 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Mon,  5 Oct 2026 23:49:54 +0800
Message-ID: <20261005154954.2097054-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1xDkx5-00036J-Hh
Subject: [f2fs-dev] [PATCH] f2fs: fix defragment writeback range truncation
 on 32-bit
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
Cc: Zhan Xusheng <zhanxusheng@xiaomi.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs_defragment_range() flushes the range it is about to defragment:

	filemap_write_and_wait_range(inode->i_mapping,
				pg_start << PAGE_SHIFT,
				(pg_end << PAGE_SHIFT) - 1);

pg_start and pg_end are pgoff_t, 32 bits on 32-bit kernels, so both
shifts are evaluated in 32 bits and truncated before they are widened to
the loff_t parameters.  pg_end is only capped by the file's page count,
so for a file larger than 4 GiB the shift wraps.

For a 5 GiB file pg_end is 1310720 and the range collapses from
[0, 5 GiB) to [0, 1 GiB), leaving the rest of the dirty pages unwritten
before the blocks are moved.  For 8 GiB the shift yields 0, the minus one
makes it (loff_t)-1, and the range becomes [0, LLONG_MAX].

The matching call in f2fs_collapse_range() already casts:

	filemap_write_and_wait_range(inode->i_mapping,
				(loff_t)index << PAGE_SHIFT,
				((loff_t)pg_end << PAGE_SHIFT) - 1);

Do the same here.  On i386 the shift changes from "shl $0xc,%ecx" to
"shld", i.e. from a 32-bit shift to a double-precision one.

Fixes: d323d005ac4a ("f2fs: support file defragment")
Signed-off-by: Zhan Xusheng <zhanxusheng@xiaomi.com>
---
 fs/f2fs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ef4d218e694b..0d9919d89d93 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -3036,8 +3036,8 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
 
 	/* writeback all dirty pages in the range */
 	err = filemap_write_and_wait_range(inode->i_mapping,
-						pg_start << PAGE_SHIFT,
-						(pg_end << PAGE_SHIFT) - 1);
+						(loff_t)pg_start << PAGE_SHIFT,
+						((loff_t)pg_end << PAGE_SHIFT) - 1);
 	if (err)
 		goto out;
 

base-commit: caae4bfcf5b5794fdf6299eb6c4fbf3d149db000
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
