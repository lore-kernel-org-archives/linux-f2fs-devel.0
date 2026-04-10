Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E331AF44869
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Apr 2026 13:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Mime-Version:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wSHcZgGMqRLOEepD4OsBLx+o1l5fGxF25aR/Gq6A6p0=; b=LxD5Y9/KC3DYbqPGnC7z9wqdrm
	SV6k74JvNMVxSwdFYp2MSJq2m+BsLJM6x7KKtXRtC3JaSJKqdaHXJlNSY6G06jnxJ1Fyz0/SoO/SY
	4v4k7eD9Wdu5HPexxudnMy9QNRHVhNS4uSAiKpKl8oEDuFzdwkSPST4I9ruOrgWVqjsE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wBCDG-0006LL-J6;
	Fri, 10 Apr 2026 13:47:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3t_jYaQwKAGIJPRUSAKOWSKIGOOGLE.COM@flex--jprusakowski.bounces.google.com>)
 id 1wBCDF-0006LE-7f for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Apr 2026 13:47:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 Mime-Version:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XBHYGu/W+MllWbifwusYwjsWD3CeuSoNa462jWa12vA=; b=aSWY1eANuNGzmVJomNCb2GLHnt
 fPmO1jH8NGEsyCKt9s/oZi5psqGQssdZcFNMBbJjMG8jIBNxfkSP8anAq3lMknSjPtpGuri0Uq24/
 nhw7vP45fhM05PtIUrFJv3EjQbkc2sCTpF69Q0V3d7kXvCYTWEjv760NvkkgKng8qzTA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:Mime-Version:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XBHYGu/W+MllWbifwusYwjsWD3CeuSoNa462jWa12vA=; b=J
 zYB12i4jaPFjsusEVyg4rVdWCHFXSJFoxpDXN8kn50VD07HIT6QIATY120fKveulvj7W0/wn9zvnP
 QuzSeJ8qsRwNveD+c5u3CTRMKHmg8NalcHR1qSSAAYfykfsaD54zk57zetxaumUSPBU/LmJGOEBcV
 IUwAmZbLicd/iRVk=;
Received: from mail-wr1-f73.google.com ([209.85.221.73])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wBCDE-0008C7-QL for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Apr 2026 13:47:57 +0000
Received: by mail-wr1-f73.google.com with SMTP id
 ffacd0b85a97d-43b9a86b9b0so2228021f8f.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 10 Apr 2026 06:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1775828870; x=1776433670;
 darn=lists.sourceforge.net; 
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XBHYGu/W+MllWbifwusYwjsWD3CeuSoNa462jWa12vA=;
 b=gKCLv0Qj6spqZJU+e/4ahlvwH8g+BroesOXvdBjwqE9AQJexVU0+V5qUlJvnVlwUUC
 SjAsWix7rUXspO0EzcrdNipbwDEsuMSQDLFjmpLBXsMtcroowt8d3xyE2B+Uv3CW+9Ur
 itjkZqEIepQPI2Jf616lQA1ukHxyBs5eTt/67Q27dJ+TeEAiUgoxNP0Ne4iKmlZ573tx
 zlD/f3v4Rjd8EYlM9IX7+JzFi+pPlf/5tOpeRAntWt5TwPJluCv8DIBzGdAlYHg7SPbj
 NQGPgVBjXGo2PwpQ9C7+GCVyNneW0xrjSJHD42S6nPN+I+EUVqQ+2DScuVvhp8Y7aPVg
 HLTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775828870; x=1776433670;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XBHYGu/W+MllWbifwusYwjsWD3CeuSoNa462jWa12vA=;
 b=OT9zde2wrSOdbgbv4a38KEdSjgP/6CHOSl/upbllBFYyN1zOruv4rNRvv5dP/KN+FO
 XSvImY36W72Z9i3rx/E59lu6g3WAJ8SirSc45mxZ1u1FOTOFcr7yqWa8FhQ1Ot+P5GSK
 QoYyUj4MSJvCUnOgAbpnqh0X8P3YFVjUx2XoWBT9AbjVA5942z9UtAGBC9T6JawgzMlL
 Z9OJJOa/q0eqziMd2D2unwRPcrWqRxgk7hxsYqtMdQ2q3PaRZ6bWoPwAwo5Kwy41JBIh
 GmgT+nQyUzgCyFNTdh6e4kTzvgk/Yw9tQGHD8CrYWdsScVYNjH/bDAhnZtOpSz+0ZU3K
 V9YQ==
X-Gm-Message-State: AOJu0YzSRO1TSU8zHPrDx2VsEC8CDNjXeB36dMAfruGKv1jSoxxI8gyC
 FYxMFR4hQUHYdw1/aNXLc4taMgXGfA10H4wbJ3z2mv2sK/o+kxQPKJAZt3qOueSm30om3QVCiiI
 9QuKq8kHfDcD8yu7ymscqwrO4i7/5xw==
X-Received: from ejcsa19.prod.google.com ([2002:a17:907:6d13:b0:b87:16d1:59a5])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:c39a:b0:b97:aea3:86dc with SMTP id
 a640c23a62f3a-b9d727a0621mr177539466b.15.1775827127281; 
 Fri, 10 Apr 2026 06:18:47 -0700 (PDT)
Date: Fri, 10 Apr 2026 13:18:20 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410131821.991005-1-jprusakowski@google.com>
To: zlang@kernel.org, fstests@vger.kernel.org
X-Headers-End: 1wBCDE-0008C7-QL
Subject: [f2fs-dev] [PATCH] generic/050: handle f2fs as nojournal filesystem
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
From: Jan Prusakowski via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jan Prusakowski <jprusakowski@google.com>
Cc: wqu@suse.com, anand.jain@oracle.com, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

F2FS uses a checkpoint mechanism for metadata consistency rather than a
traditional journal. Roll-forward recovery is only needed if there are
fsync'd files since the last checkpoint.

In this test case, files are created without fsync, so there is no
roll-forward data to replay during mount.

Therefore, F2FS does not need to write to the device to recover, and
successfully mounts on the read-only block device. Thus, it should be
treated as nojournal in this case.

Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
---
 tests/generic/050 | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/tests/generic/050 b/tests/generic/050
index 3bc37175..3a641a65 100755
--- a/tests/generic/050
+++ b/tests/generic/050
@@ -46,6 +46,18 @@ elif [ "$FSTYP" = "btrfs" ]; then
 	# So for this test case, btrfs will not get any dirty log tree thus
 	# it can be treated as "nojournal".
 	features="nojournal"
+elif [ "$FSTYP" = "f2fs" ]; then
+	# F2FS uses a checkpoint mechanism for metadata consistency rather than a
+	# traditional journal. Roll-forward recovery is only needed if there are
+	# fsync'd files since the last checkpoint.
+	#
+	# In this test case, files are created without fsync, so there is no
+	# roll-forward data to replay during mount.
+	#
+	# Therefore, F2FS does not need to write to the device to recover, and
+	# successfully mounts on the read-only block device. Thus, it should be
+	# treated as "nojournal" in this case.
+	features="nojournal"
 fi
 _link_out_file "$features"
 
-- 
2.53.0.1213.gd9a14994de-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
