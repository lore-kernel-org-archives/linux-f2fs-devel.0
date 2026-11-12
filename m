Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C2BB60A5BCB
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=FQHXLoqe;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=DH8cDoZ7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Z7cTFqji;
	dkim=neutral header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=QCjzYi3k
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Mime-Version:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Unsubscribe-Post:List-Owner;
	bh=/+RSiAhD4X8xioiq2W2NsJYT5zaE3HTLI2w8drSmfOQ=; b=FQHXLoqepjsmNutr1YJUjnpL6s
	Pl1Yx2oU3ORGvOfOCHd6gDgvkakC8UMPXAmSGJINRwNPj8vC/Ff/b5yoKsABJul+LpGo/gIy2cKYr
	PU6W4XXEi4QpYT2cYxZPz+frdnMSXGC/Aa19fuum9qIDJ9Ei7MqgC+WdOTvFvxo62BTk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRVwf-000000001e3-23K8;
	Thu, 12 Nov 2026 14:38:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1) (envelope-from
 <3X8_1agwKADQZfhkiQaemiaYWeeWbU.Sec@flex--jprusakowski.bounces.google.com>)
 id 1xRVwe-000000001dw-0TIO
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 14:38:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 Mime-Version:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HeUccQNkRQfEx+dOXAstHVvN1uagPZa0GlfKzv8IIqA=; b=DH8cDoZ7yZ3dEhS2QqDUG7RSla
 hK5tQ6SInqJode/fB1hT2fmkKau9lSh17MYuvSl6KHZupalgJsZdErWuHjP4X0Xez4EBp2NsKKddq
 hIFrf3MXHL+68N3hBBdV5GHx4mWCeGUnHMNYkftU+d3J379B4qCA4NuQ/RS0GC2MVpks=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:Mime-Version:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HeUccQNkRQfEx+dOXAstHVvN1uagPZa0GlfKzv8IIqA=; b=Z7cTFqjiqOtdvYDa1EDpXb1Tsa
 4E7iB1tCQ5tkupN5i5uelLtATEiOLC1EKMPe1mOZg+6SuqRZf5Is7s26iVtsGR4Jrq91F80/uCtFI
 Fmv6qy0BUpbtL0jUSgOzX8XQTu3Q+MMgUthZdX6Kj/X13Sd5QBTzhcloUnp9s1l7Wq5I=;
Received: from mail-ej1-f71.google.com ([209.85.218.71])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRVwc-000000007r7-2M4I
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 14:38:32 +0000
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-c50681426b9so199933366b.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 06:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794494304; x=1795099104;
 darn=lists.sourceforge.net; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HeUccQNkRQfEx+dOXAstHVvN1uagPZa0GlfKzv8IIqA=;
 b=QCjzYi3kfam44PYwC1T3GLOaluZIdxO1bNulz+Ld/fI+Nx74JI0+5CmrORQ5yli/On
 IerAA/qxBKNmXgu5G55AFox3sGIUm2Q+8iqqmG5z79d/gO7fUKU9lYEd0o0no8kue2C0
 95HHqNwii2FFLmvFHdOzdZnkiiMhu8JAv/X8g+XiBBMozGM+lYaK1XeR1CCozyaxZ5no
 Vst7dJ13eySzL7W0N19TyXmvk4ik2imFPAQX/dQ/yPuv3bhwKzKCkAqGcvU6j5H+xyoA
 nvwOCIxj1/8wVYkjKhtdUrD+OcO0KEAIoejsttZdIikqQ3Hdmu3Bcs3+fiek9vNpv7SS
 4y0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794494304; x=1795099104;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HeUccQNkRQfEx+dOXAstHVvN1uagPZa0GlfKzv8IIqA=;
 b=oNQGfw9/+pBZQogpMxNzndVz76VBHtO0x6a2h2dFsLYmmJEWvxos9aABKb5xfH9JX7
 cxLl2Jv1jiA9TRaNtotli/BihtlhlfbMYaheTvjx8VpPc+OVSdFUkBM9icwfPc6IhjRW
 TtZ+GK1yRqJaqq67kCv4cpmR83ZMGCPdw6coLuRXgMhMeIQPrdVCMHtQM5QfAZosavpR
 l/Kho5Iqmivtc6hV06URySQlzCvpKcRZo3/kz1jGzifQKqJb5dZAa4vuy0koIUeuFmRN
 WeO+Afmml/6r4PSfz5Ovz7UFYbhtkkKijM0tFk6evU/007cwrjWphDvTIWc83kOKWix7
 bSBw==
X-Gm-Message-State: APuU4Z8eInot6nEfHFq9LN73cx93LdbGk8HqtO59UbbGPqTy7NbQptNh
 8x1+SpWjQT2dJxdZnnnecsxmeiVC9jTVCUFrQNa44WHQzpszzZyvpXMO8Yow7Dts+I9pvNF/fS4
 W4MO0/MbUbtGhlLL0f+WzhiXWf9DLJw==
X-Received: from ejxn14.prod.google.com ([2002:a17:906:840e:b0:c35:d623:cdf0])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:7955:b0:c2e:5efe:f1cb with SMTP id
 a640c23a62f3a-c5066abac50mr522369166b.8.1794494303817; 
 Thu, 12 Nov 2026 06:38:23 -0800 (PST)
Date: Thu, 12 Nov 2026 14:33:46 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261112143355.2923939-1-jprusakowski@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Spam-Score: -7.6 (-------)
X-Headers-End: 1xRVwc-000000007r7-2M4I
Subject: [f2fs-dev] [PATCH RESEND 0/9] f2fs: fix stale data exposure on
 failed O_DIRECT writes
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Jan Prusakowski via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jan Prusakowski <jprusakowski@google.com>
Cc: Eric Biggers <ebiggers@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Resending to include Jaegeuk Kim and the mailing lists
(linux-f2fs-devel and linux-kernel), which were accidentally omitted
from the initial submission. No changes to the patches.

When an O_DIRECT write fails with an I/O error, f2fs can leave the file
pointing to blocks that were never written, so reads return whatever the
disk contained before, possibly data of a deleted file. xfstests
generic/250 and generic/252 check this for direct writes to fallocated
blocks under dm-error, and both fail on f2fs. This series fixes them,
along with several error handling issues found on the way.

Patches 1-2 fix issues in compressed file paths hit by these tests:
sleeping in atomic context when reporting a decompression error, and a
read error in prepare_compress_overwrite() stopping the checkpoint
instead of failing the write.

Patch 3 keeps the old block address in the dnode when the block
allocation of an out-of-place write fails, instead of replacing it with
NULL_ADDR.

Patch 4 makes the buffered fallback of O_DIRECT writes return errors,
following direct_write_fallback(); generic/299 hits one of them.

Patch 5 truncates blocks allocated past EOF by a failed direct write.

Patch 6 tracks out-of-place block updates while an O_DIRECT write falls
back to buffered I/O, and rolls back those whose write failed, restoring
the old blocks or resetting the blocks to NEW_ADDR.

Patch 7 records blocks allocated during a native direct write (for holes,
preallocated NEW_ADDR ranges, and out-of-place overwrites in LFS mode)
per kiocb, and rolls back any unwritten blocks if the direct write fails
or stops short. Overlapping reads and writes wait for the in-flight
allocating direct write to complete, while non-overlapping async direct
writes proceed in parallel. This fixes generic/250 and generic/252
without falling back to buffered I/O.

Patches 8-9 fix compressed files (where O_DIRECT writes fall back to
buffered I/O): patch 8 cleans up when a compressed cluster write fails
to be submitted, and patch 9 extends the buffered fallback rollback to
compressed cluster writes.

Tested with full xfstests (-g auto) across default, compress and encrypt
configurations with CONFIG_PROVE_LOCKING and CONFIG_DEBUG_KMEMLEAK
enabled.

Assisted-by: LLM

Jan Prusakowski (9):
  f2fs: compress: avoid sleeping in atomic context in
    f2fs_decompress_cluster()
  f2fs: compress: abort on read error in prepare_compress_overwrite()
  f2fs: keep old block address when out-of-place write fails to allocate
  f2fs: propagate errors from buffered fallback of O_DIRECT writes
  f2fs: truncate blocks allocated past EOF by a failed direct write
  f2fs: roll back failed block updates of O_DIRECT buffered fallback
  f2fs: roll back failed block updates of direct writes
  f2fs: compress: fix cleanup when a cluster write fails to be submitted
  f2fs: compress: roll back failed cluster writes of O_DIRECT buffered
    fallback

 fs/f2fs/compress.c | 179 ++++++++++-
 fs/f2fs/data.c     | 185 ++++++++++-
 fs/f2fs/f2fs.h     |  99 ++++++
 fs/f2fs/file.c     | 745 +++++++++++++++++++++++++++++++++++++++++++--
 fs/f2fs/segment.c  |  49 ++-
 fs/f2fs/super.c    |  11 +
 6 files changed, 1217 insertions(+), 51 deletions(-)


base-commit: 9b12299b437e0cc3ebf402e7b36a89cc69151238
-- 
2.56.0.567.gdb80ae8cd5-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
