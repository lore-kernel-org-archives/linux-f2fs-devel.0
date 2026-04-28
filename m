Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AB1CFF8867
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 28 Apr 2026 02:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Mime-Version:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jsa2UCRlM6SzloBSsY3CcrEZYBhhA0jv91dlgCBss8g=; b=CMChQhhnxJtmvsuNec04JpYrKV
	RtOMClLoR3qEINzRqsN9vEewIjZOoM2htXFjroEbE68EU39077P+IVwJPQ69LQf2gHAxncyw5kFU3
	bnvnw8yrqAm9Fs4m3vHfBH1pqmy5BGivh9KZnZaGr7gLjQcTBdQn/2mgGiVZv34f7eLk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wHYUW-00055V-MS;
	Tue, 28 Apr 2026 02:48:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3oBrwaQsKAOsWbNaaRPUVRaTbbTYR.PbZ@flex--joannechien.bounces.google.com>)
 id 1wHYUL-000554-PP for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Apr 2026 02:47:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 Mime-Version:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3m05/BsuNkWxYo7vhXnQHY/IOh7XjJaCl15WycXKBlw=; b=MCIfeeGjwBxSPejVPGm7ksVQp+
 WRfrSRG8zYbrSeklGg5ybkLKUA0wNEYzJmjZUFG2ZSqqv1UXMkiaKoyGpk4sab0O8Pi4MXuBJ0ZC0
 NLXu/no3/pbKYXNb6eT2jQcvqWv3QZ7C6rPiC6YjQ2okf43SbjL1AxIDBb3c89FroSVg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:Mime-Version:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=3m05/BsuNkWxYo7vhXnQHY/IOh7XjJaCl15WycXKBlw=; b=b
 lAIRt/H9euBvW8BvV2aniN1xDodlKnCb5+T2pvrfLzgCOs2CgCmLquydRMc0i3WYxeYomxSrkj1kZ
 2LEaUaOSnZ+Zg7dwmfPNYDiKTGjxoOXW4VlxVQzaCL2M514Fm6oMMtIOihk7C+dDBGlKWKqJHftUu
 8IybJ9q7uYtjNBcs=;
Received: from mail-pl1-f202.google.com ([209.85.214.202])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wHYUL-00056a-CW for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 28 Apr 2026 02:47:53 +0000
Received: by mail-pl1-f202.google.com with SMTP id
 d9443c01a7336-2b2ead99f5dso135617885ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 27 Apr 2026 19:47:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777344468; x=1777949268;
 darn=lists.sourceforge.net; 
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=3m05/BsuNkWxYo7vhXnQHY/IOh7XjJaCl15WycXKBlw=;
 b=jWnRs4cjyatQh/f6Zez7mLdSR8JbdiFrRJmkFh9FPyG1sl8UdAYWA13p8cd/+Wk0Ga
 xEv89aySvkbPzWioWm1OF0OOJnvXrt9DtY6kC29U03VPdAK5+9EfRpOpS0QU1j4zi/Iv
 DqnJdxPObF3cIyPgduviMCiwE+XjXab1lk2sK4P+WmYzU3oUX7ijBnG6bsP193r9egd+
 /IqCGkCMelDs2LANLtZo/lzkugHgw1yybIcSh3Az+RGyd0Uf2DfLiGInNwSiHAlc8fRK
 AkmNc1ltk/ZJoOO/2XQ4vuY49vqhXhOKi39I6px1dqaHvR4/BCLj8iPUeirvn5x1fYed
 hMfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777344468; x=1777949268;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3m05/BsuNkWxYo7vhXnQHY/IOh7XjJaCl15WycXKBlw=;
 b=OUbgp1ZU3MrTIwx/sUb9L1LD+RD1cxaTh8IGOmAQCVgXE9AH0Ap5ZsRGAcBnn7Y+pE
 bLtYnbgItu4jgMsvVD6CNug1ZW3Ya65T11CDFGxfllCP12Y3Qz5DWtvIOjhFFGeqbX6H
 WiHtHqkYrZFm/nfgHp/2W1FkyKlo4440/G1WhbKLDVjsXRwGCjaex/Swr0OkWvkatFJi
 UeKw1n2wzZfily3RB+XXE3EIX4KZldeicnu1lAF/vDYqlLi5wTLUpc+gzyRPYVAxnx2n
 UrOqRa2PG9yMxEZCvCUjrK2RZDM4N++AUe1tquOf8K6M+Pyuw15mrJmuuIn09/Chq5tY
 ABrw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+lnWdGYOw3N7wM8v6ge5kX0sD9Jr3njs0M+3jH0anDEIHdG8jIithjbB/kZ9U3b3cIlhdHH7jU2t/BX9rbiQBj@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyLrUmRnP6gvh/Euygp4V1y2Ayd0IbJHmAORmipSiwe4bxIDRml
 I1byAcW7OID17w1ZTh2VTbz7g5PvzZKnP3u87KeW02ft9zgCbly0QdJ0iGG8ueCHn7aasdr9p70
 lPxfkropdJNQ0X9GenBfwbE5cSA==
X-Received: from plnr13.prod.google.com ([2002:a17:903:190d:b0:2b0:c9c5:109b])
 (user=joannechien job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:778e:b0:2b4:65e3:488e with SMTP id
 d9443c01a7336-2b97c4b8eeemr8219225ad.40.1777343136633; 
 Mon, 27 Apr 2026 19:25:36 -0700 (PDT)
Date: Tue, 28 Apr 2026 02:24:40 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260428022440.2481342-1-joannechien@google.com>
To: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
X-Headers-End: 1wHYUL-00056a-CW
Subject: [f2fs-dev] [PATCH v1] f2fs/{022,
 023}: clear MOUNT_OPTIONS alongside MKFS_OPTIONS
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
From: Joanne Chang via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Joanne Chang <joannechien@google.com>
Cc: Joanne Chang <joannechien@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Currently, f2fs/022 and f2fs/023 only clears MKFS_OPTIONS. This causes
the tests to fail when leftover MOUNT_OPTIONS depend on unapplied
MKFS_OPTIONS. So MOUNT_OPTIONS should also be cleared to ensure reliable
mounting.

Signed-off-by: Joanne Chang <joannechien@google.com>
---
 tests/f2fs/022 | 1 +
 tests/f2fs/023 | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tests/f2fs/022 b/tests/f2fs/022
index 728ef4e8..854ec327 100755
--- a/tests/f2fs/022
+++ b/tests/f2fs/022
@@ -23,6 +23,7 @@ _require_inject_f2fs_command node i_nid
 
 # remove all mkfs options to avoid layout change of on-disk inode
 export MKFS_OPTIONS=""
+export MOUNT_OPTIONS=""
 
 foo_path=$SCRATCH_MNT/foo
 bar_path=$SCRATCH_MNT/bar
diff --git a/tests/f2fs/023 b/tests/f2fs/023
index 33108421..f3e8785f 100755
--- a/tests/f2fs/023
+++ b/tests/f2fs/023
@@ -25,6 +25,7 @@ testfile=$SCRATCH_MNT/testfile
 
 # remove all mkfs options to avoid layout change of on-disk inode
 export MKFS_OPTIONS=""
+export MOUNT_OPTIONS=""
 
 _scratch_mkfs "-O extra_attr,flexible_inline_xattr" >> $seqres.full || _fail "mkfs failed"
 _scratch_mount "-o inline_xattr_size=512" >>$seqres.full 2>&1
-- 
2.54.0.rc2.544.gc7ae2d5bb8-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
