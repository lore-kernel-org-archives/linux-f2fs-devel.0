Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74161C982DA
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 18 Sep 2026 13:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uIXyFrP9FMrovLDEvbhmQ5vBHP4lFf/vThPHfFCdpHw=; b=aqpEd4ISuJNxGO88pu4gF9GiXD
	P9cOgRH4+6un0TS0OUZ563b6SFyfzDgg/q8MpqTA8vmnAX8k263xMdvJfhAtu9MZpK2zMmUMELdB4
	8V9ss9cKshtp3LtBbAU7m6yQ7af7iMRmnFHhbSJGVi1MSUkzzgpBcJlwZGhP/oSNK/gg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x7Yp9-0004o6-Tw;
	Fri, 18 Sep 2026 13:40:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jsjlee1020@gmail.com>) id 1x7Yp8-0004nz-NN
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 13:40:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mkji8nuCM5AKChpvLLQvTuvYia3k12Q8J0swVpD2+e4=; b=Oxa6FEQN8AHVXnCuhzRuJkqEOx
 SDh//dbgLYGvC9A8pKJMsd2csHf+SxirvpPF04OqQTkED8lBam8liQkvXxktNfXEyGwqoHGSGE7Cg
 VSW9qLZQ9gLbWtt85rNwsIFwGK2FTCww10Oa02pe24pmyurADX2Y2KYk1a5NiDvarfQ8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=mkji8nuCM5AKChpvLLQvTuvYia3k12Q8J0swVpD2+e4=; b=G
 6Iasie9P68TwY2FvlEQ/kT+wXCoIZzYVoC8Ra9c9FvTYPyH8hydEzD2k6sX5Xr2jBa3VGraVhUvfk
 8oQTfmJ3GSGSR0zJZkGbE5UqSkxAA6m9EOL9kbmp8AtgZC5+USqwO/O/b+1neLeAcrzgRbHeL0At7
 8OEH2ZCTyvnJ1kHE=;
Received: from mail-pj2-f41.google.com ([74.125.227.169])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x7Yp7-0002SN-BP for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 18 Sep 2026 13:40:18 +0000
Received: by mail-pj2-f41.google.com with SMTP id
 d9443c01a7336-2d91a931f66so4773495ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 18 Sep 2026 06:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789738812; x=1790343612; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=mkji8nuCM5AKChpvLLQvTuvYia3k12Q8J0swVpD2+e4=;
 b=AeLkTF/KFlJL3uJM3Q6pdLU1et5zOx0zicZyOf4qY87D5QNSXKYBiPcyJ/P0r0BJtl
 2CX5y/dsgAxA5Y8TFu/5ATPBzFlLh6vmYYzDe3Mik63AoneYRx05PpDN5I+nNjIjz9qv
 uctVCytod2fYu4rzc83KuIE9Om20KoZyiPQOqpBNvFHGjP/Yzt9Oi5ypNRGhHHi8C8Bo
 UJIrv+o5icWCqxAw2W0ejIRwMZYnLL4Zz2Wwh0MrcwD3565O+r54+c2MhXG5+JW+6FDu
 GGlMQloQUeEZ+NgPlXUgb6SXweMZkBTEnTodJVAjgFyykjFDNCdzMxCTpOHYi55PsXxy
 hU3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789738812; x=1790343612;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=mkji8nuCM5AKChpvLLQvTuvYia3k12Q8J0swVpD2+e4=;
 b=zqUPCWZoVzBWqV/4BR2mqRmo1f23jnVaLTQT1Oxj3NSFbr8j0nMH+lPRlTlpHtLqWg
 j26jj3Mam4QOI5PHoYkFKvzcvHNKrNv4l/GSFCTkPKmtsU/CmkLeHxQMvHeeDZVAhorb
 jfXNqwkGP5qE4sK0jG+0Vif5xmu6gKjBc6dxDa8TZ3tsWSxHzn1KWKtEX+f+mzjXgukZ
 gRYRqGgLqLoeHUYECdJuTZ/MBhgDsVlVgLeOKfzRAXJ+KmMivjxImYJHZjOuq1MHDSTG
 rVUjPxqG/VtYgze2gDx/2oJi2oGBNGvuPWJ/+Ex+uVba7sk/tuCh1as5F+Kq3uGKkh21
 ja4Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxD+zcFe0qJq5NjxQabdWH/qLVRTuo5cp+zpmvu+5Dg/VX+nmcgSElyWIV22qLJep5eRje8mpCQHMLWny4rKjhm@lists.sourceforge.net
X-Gm-Message-State: AFuF++mvSqoMIEgpLR6qfixkjoRCy7Kmr67HdHrDGzbRG/CxfDKsk74w
 vejmY9JQxUzOWp8KsqWwvUCIio8QZ/BtWqpYhC5sGDuTWDH4YHNcM2Szhi9s0nl7bao=
X-Gm-Gg: AYBFou1nNkzQuJCjGf8IP+zinvkwxoOUz5mTick5aut2sRy0P53wYlGrbXWj4vSNpKu
 LMNWWb0CTf8q0Ttd9vuYz0P/0JJpF7QCpDxZuBXrqxQHSIdDA1WaeXqQduDNft8iPDz7xEhDdl/
 vy2tv19eiIRL5Sfz9M40AYUxV//Yt3x3mPq3h/qmOJKNahvYsEZAgeL6gNFxvEIIdI9OiRi5GIC
 DBhgzNVP8UN54fQK2C0hhRoWaQVmvbMih3KTMXMaGIlEbQ+69o1vynRQ4ayFKiYYiqHpiP8rgAi
 5hOGi9EZDbJzqR42rvo3i8Jkg9T0z4x8S/11BTBINtsdaX7GmFggNQJGoItzjCb+SEQzxTFw5s8
 WjlK0Sny1uOygn0i0zHzVK8Ewngr32X3/LxH5+JA+v3L3ljFb5XCT6kLmFO/W9z1qfd252VqTxE
 jK8QxpRJL1mv9RhtxkG6O14jrl8V2KqMbo2a6EPO4e9u/Qg6CDp1eneSaXm0INSPZ/6BQjVVW3h
 j49m9lN6XJoVaQpmlwuWAV94PJxVOsG+rNDkBuhlWYr3UB5LMKU+P6FVrY=
X-Received: by 2002:a17:903:2f06:b0:2dd:8e7d:90f7 with SMTP id
 d9443c01a7336-2ddb1adb4a8mr62664555ad.9.1789738811267; 
 Fri, 18 Sep 2026 06:40:11 -0700 (PDT)
Received: from
 codespaces-2362ac.ktkhmpmw22vebpok31ngjx2qsb.ix.internal.cloudapp.net
 ([23.97.62.118]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ddb7524dc0sm8031585ad.14.2026.09.18.06.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 06:40:10 -0700 (PDT)
From: Seongjae Jeong <jsjlee1020@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Fri, 18 Sep 2026 13:39:22 +0000
Message-ID: <20260918133922.8163-1-jsjlee1020@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Headers-End: 1x7Yp7-0002SN-BP
Subject: [f2fs-dev] [PATCH] f2fs: reject device aliasing without a
 multi-device configuration
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
Cc: syzbot+ae5b8eb92ed40411ce16@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, daehojeong@google.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

A malformed F2FS image can enable F2FS_FEATURE_DEVICE_ALIAS without
providing a multi-device configuration. For a regular single-device
filesystem, f2fs_scan_devices() returns without allocating sbi->devs.

In this state, f2fs_dev_is_alloc_blocked() passes the device alias
feature check and dereferences FDEV(0), resulting in a NULL pointer
dereference during segment allocation.

Device aliasing requires at least one secondary device. Reject
superblocks that enable device aliasing without entries for both the
main and secondary devices in sanity_check_raw_super().

Fixes: eae3faf210bd ("f2fs: support dynamic reserve/release for device aliasing")
Reported-by: syzbot+ae5b8eb92ed40411ce16@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ae5b8eb92ed40411ce16
Signed-off-by: Seongjae Jeong <jsjlee1020@gmail.com>
---
 fs/f2fs/super.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 6a2f09c61dcd..f980f67cd199 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4153,6 +4153,12 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 		return -EFSCORRUPTED;
 	}
 
+	if (__F2FS_HAS_FEATURE(raw_super, F2FS_FEATURE_DEVICE_ALIAS) &&
+	    (!RDEV(0).path[0] || !RDEV(1).path[0])) {
+		f2fs_info(sbi, "Device aliasing requires a multi-device configuration");
+		return -EFSCORRUPTED;
+	}
+
 	if (RDEV(0).path[0]) {
 		block_t dev_seg_count = le32_to_cpu(RDEV(0).total_segments);
 		int i = 1;
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
