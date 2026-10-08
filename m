Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01BEBCA6007
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Oct 2026 09:55:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Mime-Version:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=fmSSSHDygir3bbs9rLiyxz3wivqx5+DAV7i3SMCOcv8=; b=YdTCOromzqabsSKTQwbfo1r2V7
	bsjrMUkiytswMtRHkqIbchwrMqhJ2VaLhbgc5KR1uQCX4KFOCflxk9th86HgRt1LBpCv+kCzdDG7J
	QWuGTMf/f8YXtiUIh2vrAMxPSN+26bqwg/vI8o2TMCj9TxhkqHgqtHixjSDSq3eXByN0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xEkqQ-0003Zb-HD;
	Thu, 08 Oct 2026 09:55:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3DGPHagwKAE0y4697pz3B7zxv33v0t.r31@flex--jprusakowski.bounces.google.com>)
 id 1xEkqP-0003ZN-EL for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 09:55:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 Mime-Version:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qk2wzeUjr5cHJrsg9CCba8cREUuAl6jxOiia5ToFeSk=; b=BZHpjT7KyYLVH01jMr35Kddfpe
 11Ke2BXx7z1K0K36P5+9d2R7op2h9Ml9BJ6rIfN33o0CKpOVw3gEGfFTL9kzo5KJwjETKYXULwYwk
 ULaQ9gx1UVSMr4hYv71OMMnrsMNpUWuv2v8RIKhYjzQrjVko5/d1dRnG3S+KjYDMFqQ0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:Mime-Version:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qk2wzeUjr5cHJrsg9CCba8cREUuAl6jxOiia5ToFeSk=; b=F
 ILm91YikY7Nr+ddyQfZo/LeO567rKYatR9prewtZAt+FvHL52NogOtOfYyF5wM6m4RvAHkTk/3rM+
 PiJFTaLDX1YVnN8eRA1hlRLq3JsH8W7zbgvjd+RvpQI2l3LRnhvR9bwXwDJUUwqS+u4h8QSiHCSjs
 7dPoirlxc/7QLQjY=;
Received: from mail-ej1-f69.google.com ([209.85.218.69])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xEkqL-0005FF-KB for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 09:55:18 +0000
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c2e4d39c795so533694266b.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 08 Oct 2026 02:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1791453311; x=1792058111;
 darn=lists.sourceforge.net; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=qk2wzeUjr5cHJrsg9CCba8cREUuAl6jxOiia5ToFeSk=;
 b=uGx+YrtTDasB6Xn+6RwSOXl0grXPOzNo/0tQ7HyJfbvGKfAyURd3j5uBTHrVd1ikpk
 IfzLiijzpgRZVbIE99cXttjh07cHIxAY/KwvIF+cBNboCGLzvckpv5PImmOArVjCJmfC
 I94yqBWj0TguzsrfgSeUUpKLMf2kGlPnlvugYcwPJuXYV/0OgzYLRET7iLwoTvOTqNjp
 hpLtslzFp/p9XdpOtyEaGiVqo/j63BGPttLnfxEP0CpJKqZ/PVP0Y98nfh3Ry2sE9lLN
 xzfPx6SRj+2sq7BxWk5U9jH/8H9MRWSfRgabLDg/H3TIl7FAUqf114CZscQ18V3OL5vI
 OAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791453311; x=1792058111;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=qk2wzeUjr5cHJrsg9CCba8cREUuAl6jxOiia5ToFeSk=;
 b=UpDU40696YU52lVNPhnr7g0/NyanUh4T1bmNHtleR80B6Mnau4T1YBE0N8zPdWoI0Y
 R94LcP6hdf+MJM7jnw0bCG5oebtGQIDanhWngIkOvHa95WDV8GO0jFvbFraOTlkDNRzr
 hsYfZuhjGsYTFN+27BvCoNyXRzp2aZc/5ZSOrYG32kIGtZBUvq+EODAj5HBiqXY991YQ
 eDIer8UyYVGmtop8mjrBXALj3i6O5xniqbp7SmWGgZ+8KEuJlWQ/twty+mys0jR8Xy7f
 NqkVwoz/5udbdG7537gpkBO+IqItCNHcNn4I3Rs6MKZpBje1cenCGpWbMkJk8OaC9Ioq
 kbzQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBydzU5NGRj2HJwgIg9FmJ7WVM8xO6iHh+GTy/3usAZQBDI537IsLYgDmySNTUyXLzyH1CpsQZsV1Ju2TK5psDpQ@lists.sourceforge.net
X-Gm-Message-State: AFuF++lKQ+WxCb8MA9o0cSDRG3iNve17sHxwpYCBeCY+qzp/UOf9a4SO
 qBQYTcKxZ3CsYFcUloSzGsjRyyVTWr5hYjy1BlUqdN9p2gEP0JQrNljImmSVsCHMYrD3568agJ/
 qlhiBQp0214kNPUfaFb+SiApwVG7oug==
X-Received: from ejbbh21.prod.google.com ([2002:a17:906:a0d5:b0:c31:95dc:c07])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:dc90:b0:c2e:65f1:5c7e with SMTP id
 a640c23a62f3a-c317bdd7703mr463818766b.24.1791451916959; 
 Thu, 08 Oct 2026 02:31:56 -0700 (PDT)
Date: Thu,  8 Oct 2026 09:31:02 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.360.g66cac248cb-goog
Message-ID: <20261008093102.2791457-1-jprusakowski@google.com>
To: Zorro Lang <zlang@kernel.org>, Chao Yu <chao@kernel.org>,
 fstests@vger.kernel.org
X-Headers-End: 1xEkqL-0005FF-KB
Subject: [f2fs-dev] [PATCH] generic/794: add fsync_mode=strict mount option
 for f2fs
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

generic/794 tests that extending a file past a non-block-aligned EOF
correctly zero-fills the gap [old_EOF, block_boundary) both in memory
and on disk, and that the zeroed data persists across a filesystem
shutdown with metadata flush and subsequent remount.

On F2FS, kernel commit 5eced87b7d19 ("f2fs: fix to zero post-EOF data
when extending file size") zeroes post-EOF data in the partial page and
writes it back immediately before committing the updated i_size when
mounted with "fsync_mode=strict".

Mount F2FS with "-o fsync_mode=strict" in generic/794, matching other
strict crash-recovery tests (generic/342, generic/502, generic/526,
and generic/527).

Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
---
 tests/generic/794 | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tests/generic/794 b/tests/generic/794
index e10fb1f8..80be959a 100755
--- a/tests/generic/794
+++ b/tests/generic/794
@@ -154,6 +154,9 @@ _test_eof_zeroing()
 }
 
 _scratch_mkfs >> $seqres.full 2>&1
+if [ $FSTYP = "f2fs" ]; then
+	export MOUNT_OPTIONS="-o fsync_mode=strict $MOUNT_OPTIONS"
+fi
 _scratch_mount
 
 blksz=$(_get_block_size $SCRATCH_MNT)
-- 
2.55.0.1082.g2b9226bbc0-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
