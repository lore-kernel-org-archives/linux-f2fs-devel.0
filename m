Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2019DC433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 21 Nov 2022 11:52:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ox5Lk-0001Ef-OI;
	Mon, 21 Nov 2022 11:52:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <3TV97YwYKABw8DA56J8GG8D6.4GE@flex--glider.bounces.google.com>)
 id 1ox5Lk-0001EZ-1X for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 21 Nov 2022 11:52:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+5wrCbW2TNaYb01/tuYYFENHET5JL1U7hc5fWA+Xdi0=; b=RGz/QhNhTqKWlLoOTaCQCwd/EP
 FXgOLraO5U6FVgIyCEFo/q+/oc7WFCGss0GePw2WiW2HAvCOy6OJLVibRMjfp3CNeOPNXwjjkQSoH
 okJQJWC8YhRyVgZn+WvIcM5RMA7JyrE5ABU9VKJrGV5XvHviXGdmgtahUPWRtY6jAmT4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+5wrCbW2TNaYb01/tuYYFENHET5JL1U7hc5fWA+Xdi0=; b=j59WfqzihxSDg3Cp2bSQx3e/bP
 IwO22+La380E0FGKOh+S4RyCEwA3kClzCMu63GL+ukZPktgUgRBLEdRuumtHZMZuzoSK4WZc21HRw
 wmoUWEDUhhFx7k3nfXU2n63PPUyK3URfH+KkKBfWiP4RxaGCz62QQnK5t3TtKcjOhP2o=;
Received: from mail-wm1-f74.google.com ([209.85.128.74])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1ox5Lf-006IDN-KR for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 21 Nov 2022 11:52:31 +0000
Received: by mail-wm1-f74.google.com with SMTP id
 h4-20020a1c2104000000b003d01b66fe65so2140893wmh.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 21 Nov 2022 03:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=+5wrCbW2TNaYb01/tuYYFENHET5JL1U7hc5fWA+Xdi0=;
 b=sNA18t3VIhj8s/MCrsotPK65Vcuz2YR1Xj8oe9nNH5vPzwm6iPZt2X0Fc7s0yeYNzk
 kcVq/GLKNy4xCjOiN3dPQ1eu2GOqYtIQk02hkZfOuEd7mV/pW1ZKoMoAKwdk/WlkUczu
 VEFwbOMmBucZuvB4dVzjoZKobIlVhdSdhk1gHj3NlcrOxfhykMBq02Ddpx/UAcenV2d9
 H6fFjTIDn+cvMsYeIEIrhjMZZ74aEv343aMnLSTE4WGvBXcbncZGKe/wfws0QqQql7yX
 hbiDel8fgY1EKqDLgmq6zrkoNXrs0hkyg/paKn/mCux/h6gYGaXO8Q9fqkElW74W+eCO
 HxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+5wrCbW2TNaYb01/tuYYFENHET5JL1U7hc5fWA+Xdi0=;
 b=D7P1pLUPvp7sUTkgHPYiS1Ola1KgwO1C4lSGWLEzZe8y287VMBySgUVqpos+z5tOYX
 VzGappLxoCRKBevYzNy2tNZIfufr0BMhDF+t/rPd/d1+1gjqRAKGKOTILFv+PRNnA5yX
 tQ+Oy6BwNBdcTS2DrjxNeZlMoZ7MxWRAqCG+k2onT3CLWW0/NtUyASnb48n4LD6OTEYr
 c+nUymCnxCrfn+iAAlqllhJlyATdR1yn2lNToyyLqXiBglOefIc4wN3xhu5JL7NEzQFq
 OPI/mLD81r3WISsLdhrpZJidN7rW9OukGuRCSWlSEyrJhKJXfnd9asFKijZZK1k5kxJP
 jyGA==
X-Gm-Message-State: ANoB5pmjZ+DNVJmLFTEOoTFqkXmzV8490PUmgeSWCFq3weFz+Q1NOdd0
 QT/ZE9IfbHGSrktWF1lyohWlZ9Jf1Jo=
X-Google-Smtp-Source: AA0mqf7tPtGLz7FEjQT7OGHJ9yECs4p6OOzEpzUaOwIMlT2AhoWLN//j7QCBOd2xE5n98DwvX6ZF8x49BCU=
X-Received: from glider.muc.corp.google.com
 ([2a00:79e0:9c:201:db68:962:2bf6:6c7])
 (user=glider job=sendgmr) by 2002:adf:f086:0:b0:22e:3725:8acc with SMTP id
 n6-20020adff086000000b0022e37258accmr2585059wro.330.1669029709011; Mon, 21
 Nov 2022 03:21:49 -0800 (PST)
Date: Mon, 21 Nov 2022 12:21:34 +0100
In-Reply-To: <20221121112134.407362-1-glider@google.com>
Mime-Version: 1.0
References: <20221121112134.407362-1-glider@google.com>
X-Mailer: git-send-email 2.38.1.584.g0f3c55d4c2-goog
Message-ID: <20221121112134.407362-5-glider@google.com>
To: glider@google.com
X-Headers-End: 1ox5Lf-006IDN-KR
Subject: [f2fs-dev] [PATCH 5/5] fs: hfsplus: initialize fsdata in
 hfsplus_file_truncate()
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
From: Alexander Potapenko via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Alexander Potapenko <glider@google.com>
Cc: tytso@mit.edu, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Eric Biggers <ebiggers@kernel.org>,
 adilger.kernel@dilger.ca, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 akpm@linux-foundation.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

When aops->write_begin() does not initialize fsdata, KMSAN may report
an error passing the latter to aops->write_end().

Fix this by unconditionally initializing fsdata.

Suggested-by: Eric Biggers <ebiggers@kernel.org>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Alexander Potapenko <glider@google.com>
---
 fs/hfsplus/extents.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index 721f779b4ec3e..7a542f3dbe502 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -554,7 +554,7 @@ void hfsplus_file_truncate(struct inode *inode)
 	if (inode->i_size > hip->phys_size) {
 		struct address_space *mapping = inode->i_mapping;
 		struct page *page;
-		void *fsdata;
+		void *fsdata = NULL;
 		loff_t size = inode->i_size;
 
 		res = hfsplus_write_begin(NULL, mapping, size, 0,
-- 
2.38.1.584.g0f3c55d4c2-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
