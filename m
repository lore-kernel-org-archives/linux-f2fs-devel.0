Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D6A4F3C9AD
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 24 Feb 2026 16:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yuI5rorfA9tTst4Ko6r2/ctjHXW1vEnnYOCBYdxVVPM=; b=Bcocl3z4kko2RoH+lavI1M3tIb
	NHQ92Mm6WnMIlAvfA2WOAhTPs+W12xHwhfG9/K4fVr80GDfrHERFggVUU74GD8TNUYG/XC+3iFuEO
	mpWc2UK5E5ws8Ir3qYHJ8zZeYIM/kEJaY3gjeVmOaHKRBYoc0vTdqbU+nQqdEQJeEfNc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vuuwJ-0000rq-1o;
	Tue, 24 Feb 2026 16:07:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <kth5965@gmail.com>) id 1vuuwI-0000rf-6w
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Feb 2026 16:07:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zLa1Ik1nOym6au4YO5fi1aEg01X6lNK39crbs5JzQ/E=; b=mrlT489B15Sp57SvCj3TbpU+hE
 vedkQ4o5p8XKg7EG1aaasY11Dyk/Tr79xWp4aR3g4tUC5c2agETGq/BWHmeIFJbcCsUgwLvU2RmCR
 htSVVxanMBh4qvit5VpSBpFFmFTSfoRgL6BxnQ3mRmFOOYhKztGgpzN94KJOmgTGEuI0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zLa1Ik1nOym6au4YO5fi1aEg01X6lNK39crbs5JzQ/E=; b=h
 cl619IKaHvZCdutZ5+qnzEAu2BUK+oK9+KVhxTHq1hxwb3l1fzWWtCY5LGI9E7TVmVkf9JdTuwUft
 SkWj77dbeej3MypXsrsBiYNrmFDK/M5CYbtJQE7zhMhAoZ60UXGU9aaYT/U2PhZVFIamzvjFGNUFO
 hOSb97Cl3c1MOOkc=;
Received: from mail-pl1-f176.google.com ([209.85.214.176])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1vuuwI-0006Tt-CC for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 24 Feb 2026 16:07:10 +0000
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2ad46422a5aso1503525ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 24 Feb 2026 08:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1771949220; x=1772554020; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zLa1Ik1nOym6au4YO5fi1aEg01X6lNK39crbs5JzQ/E=;
 b=O4K4f3YSkEJjiSGcYeeD18pj1FnDlm6iTdgdr6cPaeR+3qbdgyyO7mkYIhm6JscyCo
 Jt0abBPuPs9SIE81dgnaryQbGP5HroNFffSXsWeLRIY2O2wGM2Ctwow+ALiimBWNDtjb
 8h3kS/OJoClsVAx/BCwwswtogqlAbU3RD012mRZDz327pIhewiq/kpQhhwNOe3D8doJj
 l5Mis5kheehA+2+OqW1gO60jM8UKwHD0/qS2xXlBWwEjsM7vmmOZmsBPu/WNxAJfvqwk
 GnSywXKtJet6RSfiBxDv06A8e9+ljzJSdTfhcYhLWzbQPMQmG755NZSnV+CReTmWP2Sl
 qlFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771949220; x=1772554020;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zLa1Ik1nOym6au4YO5fi1aEg01X6lNK39crbs5JzQ/E=;
 b=bzl4zvc2gLRXRP2dcO8XwErC+BMA3cPi4sAK4OLWi3U2LWuNx55s2IPG1EsnalkV0B
 E+TiORlmVONrEViaOlr+bl+NfXDncgHL5DCypysM4JrY4Xvv4uIIgPQQsZJYSv0o80Si
 PO9inK4mi5GR6SQIG/R0CrwsXsrNdzp8vDc/qx6qQ7Twui33jeBWVmPT/HecFqam1Qp0
 mAz7YIG0fujrr0hScDdAHwfBgwvACtwHfPZH8IuhuffJiSUkTxA1Ze2XyYZxSNm2MA/r
 fnBZqfk4l/+OoPAuYHW/xAZUKJ4TOalazGQ3ooDUxGGATJ/YTXJu6P6MNQUWyeXBUAKk
 ZLmg==
X-Gm-Message-State: AOJu0YwARyLRjK3AtKyXzWPW567DIQSB2+JytNU7CggyBDkKNu+6PXR6
 DV/azpOiyJNX4DYOiQPFNC9rUgSqCvpd6h7ErztGXsydYMmJDMwVt3no
X-Gm-Gg: ATEYQzyGUa3bRKr04OmJPm06J2LqUacshJhiN0/8F/QSpqCHNebbTrG6UREkpYXsbzp
 NR23ETcrPs65J6wSMyQ8r9p6enCymX4HL8BDkJDTINXimB88f+e1ButqrZTD5z9FOSeV2d8NC5o
 auxxBc9oEAsuX5P7exQ0bRpXieFM7eBCblesbJFRhbgV8GgYzyorWpRoHqL7fvgoQYinl3TjTue
 /HhHmGQzVwEElkXKSiWroamCBuHOBAnLGUCS8ofrngaQp2b6AyASmIwPs6M8PnGlFqDFMyQK9Ow
 XECXov0w050an2W7XzJagBe0piVzQ7RfCr0bG70/U/pf4o5YGTgTWlGiLfLG02iSwmjWlN3xybP
 ItKn0bciSZ0HSadWaY0Vm1nRhG41ntQn8BsthlbfLE+qitBYP8gmnL+ZSYpQaKHZNas+B3LByZi
 h1qoZfU39MoYduhP3jQXYwnrIt1f6tRw==
X-Received: by 2002:a17:903:a90:b0:2aa:df82:ed85 with SMTP id
 d9443c01a7336-2ad744020c8mr85631135ad.1.1771949219493; 
 Tue, 24 Feb 2026 08:06:59 -0800 (PST)
Received: from kt5965-NUC8i3BEH.. ([182.217.14.201])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad9f1d4b03sm26693315ad.29.2026.02.24.08.06.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Feb 2026 08:06:58 -0800 (PST)
From: Taerang Kim <kth5965@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Wed, 25 Feb 2026 01:06:54 +0900
Message-ID: <20260224160654.448538-1-kth5965@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1vuuwI-0006Tt-CC
Subject: [f2fs-dev] [PATCH] f2fs: evict: truncate page cache before
 clear_inode
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
Cc: Taerang Kim <kth5965@gmail.com>,
 syzbot+fc026e87558558f75c00@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

syzbot reports a BUG_ON(inode->i_data.nrpages) in clear_inode() when
mounting a corrupted f2fs image.

I agree with Dmitry's RFC that dropping page #0 in f2fs_truncate()
can address this reproducer, since f2fs_convert_inline_inode() may
grab page #0 via f2fs_grab_cache_folio() and leave it cached on the
clear_out success path.

However, clear_inode() requires the inode mapping to be empty, and it
is hard to guarantee that the page cache can only be populated from
this truncate/inline-conversion path.
Make f2fs_evict_inode() defensively truncate any remaining page cache
before calling clear_inode(), so nrpages is guaranteed to be 0
regardless of how the cache was populated.

Link: https://lore.kernel.org/linux-f2fs-devel/20260206092958.578191-1-dmantipov@yandex.ru/
Reported-by: syzbot+fc026e87558558f75c00@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fc026e87558558f75c00
Signed-off-by: Taerang Kim <kth5965@gmail.com>
---
 fs/f2fs/inode.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 38b8994bc1b2..5527bd76f62a 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -1001,6 +1001,13 @@ void f2fs_evict_inode(struct inode *inode)
 out_clear:
 	fscrypt_put_encryption_info(inode);
 	fsverity_cleanup_inode(inode);
+	/*
+	 * Defensively truncate any remaining page cache, e.g.
+	 * f2fs_convert_inline_inode() called from f2fs_truncate()
+	 * may leave page #0 behind in the page cache when the
+	 * inline conversion takes the clear_out success path.
+	 */
+	truncate_inode_pages_final(&inode->i_data);
 	clear_inode(inode);
 }
 
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
