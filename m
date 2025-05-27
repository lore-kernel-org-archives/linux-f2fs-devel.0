Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09119C54F30
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 27 May 2025 16:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GhwzRQJN41wIqXuHxH4yBGQGu9Nf/H7PE5q5Cn3Q3oE=; b=Kp22M0rJStPuovCLjw1JIag642
	J3QlF+aZPi+E1Vk5gwjDJswT2NzOZjdg+98qi8jP+dcyicx+1hD5f76gwECVD+P21hMLFymabCEn7
	kFKzLT67uGqax4VpYMmkIbB19ZF0w3KyBe/8ngqesRmpUBIt5B4NLPwfGp+utAX8fWXA=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uJxZK-0006i3-FL;
	Tue, 27 May 2025 16:54:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1uJxZJ-0006hx-5d
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 27 May 2025 16:54:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bzYNkPFcMltrg6TL9/1vuS1CMZo3Xbc2uegEKuHwEG4=; b=cAQS7KrCFYjERbXnuL/tj2ZpuW
 VtamUPvlBgpuyICZ7Jq/cU4cG4u8YYchh3/IjDa2E69yvfKkMgs6vRMs7z7KWb6vseDQPlABEGvrr
 geU8vNWqnRPvAiaey8WwvJX3YEigKdst9krdnpZ5gAF11EUza5BUZ29znaOq4jzOFZ2M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bzYNkPFcMltrg6TL9/1vuS1CMZo3Xbc2uegEKuHwEG4=; b=m
 HPdsAq+XeUrAwLsuadfU1HDp9J9u7zE/jWnhb0EwQM9bZE2L9fccjLTU4zbe7pw3Wqb5yzx/MeGDx
 E6jmZU/O5Wp4VRbTF0ERQQT9+3SSQH9PuISdM+Yv9dAqSKj9Q2uAGm1OdP2lpCB1f90UexZ4SGdUC
 2f97eYrHtc/AhelI=;
Received: from mail-pf1-f182.google.com ([209.85.210.182])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1uJxZI-0002zh-In for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 27 May 2025 16:54:25 +0000
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-7399a2dc13fso4017006b3a.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 27 May 2025 09:54:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748364859; x=1748969659; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bzYNkPFcMltrg6TL9/1vuS1CMZo3Xbc2uegEKuHwEG4=;
 b=cQ+5n6MsNbYYiqHmFTRyjjLdaeOmegGIsDFrCmtxLzXu2CEoiOTPiauNDoz/2jrvYg
 UJelqbEEC0HMBtiUMHztP/VIy/rxu28461UZdsh/ZZLZaFKswZPYR5wy+6ZRL0N5i5id
 c3TEID+a7VoSjDQPs2OqfqKyT7Nf3xjnW8zjoH/DjFLOvn38LxPQ354NLaMiyHL3BQqL
 q6Sc5bBRnP1BJ1KTfClZF210wbN7ZpWmhJ+BhBipHYfet7oADlPI/zF8dNaMdbhvCEjo
 u9g8R+PSnwx4PiN741CRWNAu7MDfkruf7vfkMN4pT/1JSkie2xv3maPCZyf9u8bYAz5j
 yL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748364859; x=1748969659;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bzYNkPFcMltrg6TL9/1vuS1CMZo3Xbc2uegEKuHwEG4=;
 b=f6bKK6ZrUaL0RENBA2hRFnCQAEzdSOOdjyL8C0IpO5M3j8xEQ826Xd7o7G7Pm0CwqN
 syzRfyFMMOEw5IVSi/qfL5l2Fx5KtV8sEuxyxJNbky6cXe7nUNk2M5AOunZVSQZMvvCo
 T6rKgUG4gbjZSvXXEBOuKJw/yT5k2kPJpmVqqU8tDUvnyokQ/4zZ4wgw9AbEeiR2n9QS
 8obv0j3+LkoUcoCt4TMAA5Fn969Ys4ynBMHM2tcqVZl4mIftwQoELMfrqKogiui8uqGu
 pVPRb7LwbxAfYzB5tt6bYAJlFRtHQt0uKmZ+kaEQI6ndAP0rs37iR9lKTsXGw3cOxUKf
 75XQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRXyRyEGAqHx24sAMfw97/7V1ocWBLKC+ROplJICbS0qpi5pvylJAzwbCNzRRoYB0JSe9ORFLDK5IoaIz/hIRu@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxQXOgzXyy5/imZdDl2czSF9oobMEUq0OLbBbBjadolrlE2PX9Y
 cfXJkscmqSDO+ahBU8ZMLnfpZgtcXQbsvwBigqDXyo4HZvAjMClplWn0
X-Gm-Gg: ASbGncsHvjFg4JY5z8ksgRisdl1+1oTE8MUjKKt6z+Ad+7oAhyNQLmL5BqwH86ewfAN
 aWXYle8t8yDkVu2QldQXflgM7k+HSdXqCnR2J4Rc/pTALAObpRnHqb8Ls3WYR2KxCginxyLDSrY
 +v0b2aLFt5R75Xc2Rq/Rh3L/4HQlvoByr7o1UufSqy1qWFkogVc8mQZcCOfxNiKjejacOR/4n6f
 CkgM98m/RGYOwGYJ6De0EaQuCXQs2dq80XEkojcpbx8ODj1Qct/Yjfc1ietro1f1ZgaGqWqeXZw
 QymQtyQBlLJD626FEXDPWuQymh7Xv+oBfoOpc6O845oSmMx8DE7p17cmWlTey0Cs/x42ycZSzW1
 TyObEkM8B8oqlbR7whjuYNo30VbPmSaDLS2Bxh93S+t0=
X-Google-Smtp-Source: AGHT+IFAEB/+zE1/tZp07UbvN9K23fTJlwCsIOkdRtfStGH7X1oSnvSjdzdlzt+6dEvD1qydvxUmKQ==
X-Received: by 2002:a05:6a00:3d15:b0:736:2a73:6756 with SMTP id
 d2e1a72fcca58-745fe0701e2mr20685892b3a.21.1748364858662; 
 Tue, 27 May 2025 09:54:18 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e14:7:76b7:939a:4a34:9771])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74628cc6b74sm1463827b3a.135.2025.05.27.09.54.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 May 2025 09:54:18 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Tue, 27 May 2025 09:54:11 -0700
Message-ID: <20250527165411.3724453-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.49.0.1151.ga128411c76-goog
MIME-Version: 1.0
X-Headers-End: 1uJxZI-0002zh-In
Subject: [f2fs-dev] [PATCH v3] mkfs.f2fs: ensure zone size is a multiple of
 segment size
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

Otherwise, it doesn't work with a crash.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v3: make the condition to be a multiple of segment size
v2: relocate the code
---
 lib/libf2fs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index d2579d7..7a9245e 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -1347,6 +1347,12 @@ int f2fs_get_f2fs_info(void)
 			}
 			c.zone_blocks = c.devices[i].zone_blocks;
 		}
+		if (!c.zone_blocks ||
+				(c.zone_blocks % DEFAULT_BLOCKS_PER_SEGMENT)) {
+			MSG(0, "\tError: zone size should be a multiple of "
+				"segment size\n");
+			return -1;
+		}
 
 		/*
 		 * Align sections to the device zone size and align F2FS zones
-- 
2.49.0.1151.ga128411c76-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
