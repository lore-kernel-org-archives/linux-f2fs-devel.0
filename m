Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30F5606A325
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 08:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=hWXrYTte;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=E4XCamEL;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=J+L3+yZ3;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TSwZQYkV
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=0GrodSIH2HRNL7LjJUkKf/L44FDhIW/UIxtD4AykEt4=; b=hWXrYTtec3kGRkAEfWhsYPVQce
	UWcMbAA1gQSlvgjpkSll+j1czwRxETd+dKIYAplkSA+jN5Gwke6b3ce/q5hAwSx3y7LHCsorrcbIU
	RKAtsnWGf6CsuDNMAQsG5/mhr0o/gZ3vuScfJD9hhuB7h/2NhPPGNG7Bb7sxB8tLXUuM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUK9L-000000006iq-1EzZ;
	Fri, 20 Nov 2026 08:39:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <dennylin0707@gmail.com>) id 1xUK9K-000000006ik-23GR
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 08:39:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TVN9gvvNujEIXtZTQ1E4kuWF5NZhZv++97N2Q59Z2xU=; b=E4XCamELERydTvmYc3zGYTQ5Rc
 o41p8vyqCCHup0y+RvQ/gc5hXRiwP5Y2g0pmErLLVS/kBtvhq63oewaY24ZqK67zB0U4hktYpn1Ub
 PY7GSt8AwfbPKWFSB+FpY3THDpL8hj9PGY0Si2P/TagtcIMHqBMBsxkeUurPAGUInQU0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TVN9gvvNujEIXtZTQ1E4kuWF5NZhZv++97N2Q59Z2xU=; b=J+L3+yZ3Stt5hjLdMkTH3YBBYT
 822D6ZWMUjR/eX9WZIRl5ztpJ3fv++SP/WF1X/pygPkorXLyWt3xHUV1sswwfx+nFft7nv3Yo3K6t
 i4vnHeFCo/KmL6aY+/snwzyCbeSgkHqt5ILIe0evHSb3i4kdk2H4sqkXou2tZQpAFpL4=;
Received: from mail-dy2-f8.google.com ([74.125.229.8])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xUK9H-000000000dC-3qFc
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 08:39:14 +0000
Received: by mail-dy2-f8.google.com with SMTP id
 5a478bee46e88-381c5130f4bso153701eec.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 00:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795163946; x=1795768746; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TVN9gvvNujEIXtZTQ1E4kuWF5NZhZv++97N2Q59Z2xU=;
 b=TSwZQYkV97H3fqYjSchEPKoA2e+hs888R/BRDcsh/8ipzqFN76iDjRHYVJZnCuT2ym
 qX+PSQfUxyKBB1odpnN4rgsTexuHEVa0uWR2PvwKd9xWYKpAkzvs6GcFtjSWm/zFwaFW
 mElGFkSyzPDWjZNBv80Aq+aGUmn/FSxRjXbajzDKpxAWiTvkI87oJ7wxNzeHUDuL1Rhb
 f0+ZPUNOmesNNdnRWElMLEEh0BfLL9lcRYHTYt8IwXj04TlQQYXinBz62egsmy+RaDae
 NQ7DExP4hnzNJ4Hs5g5IzrvEX3ni8BnL6uNIK5plVAm6vwR8Vnhgv8kG5E6SekEEieJR
 H3VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795163946; x=1795768746;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TVN9gvvNujEIXtZTQ1E4kuWF5NZhZv++97N2Q59Z2xU=;
 b=UWChf98/1Twi+bGuMj94fzrtSYev2vPU0Fy/CyzmuparlhqMhtqfOIVNg8jc0bGMMu
 jUz/tuMtsLK+gbcJcGcOtISdux1ulQjxCdxG6g9yH0Bh8Rz4vdDfqlFU5nvS2sVi6IUa
 n8VJKILuyOTmGcpKoH3kqAgTbNxA5wWnd6en7cDBVpMWs6Q7ztOWLPsgKjSdKTmdXpod
 YeSxNTcpm5bK8AKW0AYJtHhZiWLRdjX7B4nedPq9HYcUQHBua0FBqS+/Hv8AatJNFmIY
 j4Rai87hUi+OfoBXzuNkfZEfmAoXAR0WdZpCRBTIafosLuEXXSzimMtKB8K7AAlIpfCS
 xGyg==
X-Forwarded-Encrypted: i=1;
 AL+hErGwOi/ZdGfIFiujlFW1OP6S92/YpeIAJQHqcqKxYMWyVwblTdOb1ghj/GazulN7iH5zWKZ4HGo0DzPm5DCLr6GD@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8mBSYpMD+MFmBKrIBkZV5/jL2dJKl9XoBkzG0s/y7JMxNdB6tX
 15ypPgEBKwQDK9xlOG1bsxEEcBwMVwwbT7fiXHpA17vi2aKKRLGawnci
X-Gm-Gg: AZFdTZfjwlAjfSVCidYDL82Q/4nKJpPqolF5/yNTLPVU8zLoqgQOEUdu6BPOJ8K5Dii
 blP57mfPHFQrRkoI/uDFxozNzjfwqS3eZvGf1YYMpE1gfUNlIwICenuxEccjVpyWOcUIVSoeTg8
 7dJjT86p8sxQ6f9HhGkFrOLpTjpdvNuCUQrw0Bx6tB4w8DPEbAjWy0/aKTtFhtBEif2CP0AgHM0
 wGfbKttBZyF9IHb0RLmWmbNXaC55+Jpwc2jBjSq71eZWkvKp046Rrs95eGnr8jnEfsM/+k5M2od
 jZ6wCD1ku8rSz3sOmXsLzfuNkdaWTAJzQMRO+puzNCtyK8QQFdRa9RvW0DjswV/OlNTXouTgjma
 VkpiDPS/81Zkj4XrDyFgh0ng3guPhSMGJ81XdbHniITV5bsXYlTHwBlQcXpdvtBjxDbGt4l2Poh
 1cwkJb+gRFjic6VAutlBxolgN9LwYeHmq9i6V6DTvIjywFB/t1+8erp/fKIiNGhwlIzjqJ+SjIe
 fimkj9qe5+b1/ajUJTmveteI03vzRjYjqUW+G3QXv4fJyGBwo3+Z2pmbXE2TdGva4+ATJ4VmIHN
 oCw07E9LWVtSW38jrLhCHeScOPFleiM+jPbZm7YC3IcOFJX9KJo8rzxXR1ShH0KJVa1wpqYfNTR
 vZli96I9m3RVaXp9GVfXC9lyJcRhAUeXo882dRLfbttJdZt4dwVcghqjPIHdw
X-Received: by 2002:a05:7300:339a:b0:36a:18e2:64c with SMTP id
 5a478bee46e88-3856fd5bf6bmr2021691eec.11.1795163946269; 
 Fri, 20 Nov 2026 00:39:06 -0800 (PST)
Received: from localhost.localdomain ([98.148.34.5])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38566fdce48sm6297369eec.14.2026.11.20.00.39.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 00:39:05 -0800 (PST)
From: Hungyu Lin <dennylin0707@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Fri, 20 Nov 2026 08:38:57 +0000
Message-ID: <20261120083857.40170-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xUK9H-000000000dC-3qFc
Subject: [f2fs-dev] [PATCH] f2fs: reject immutable and append-only files in
 atomic replace
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, dennylin0707@gmail.com, daehojeong@google.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

F2FS_IOC_START_ATOMIC_REPLACE truncates the file when the atomic write
starts, and the commit drops the old blocks. It only checks that the
file is open for writing and that the caller owns it. It does not look
at the inode flags.

An append-only file can be opened for writing with O_APPEND, so the
owner of such a file can remove the data that is already there, which
ftruncate() and open() with O_TRUNC do not allow. For an immutable file
the same works through a file descriptor that was opened for writing
before the flag was set, although f2fs_write_checks() refuses writes
through it.

Return -EPERM if the file is immutable or append-only.
F2FS_IOC_START_ATOMIC_WRITE does not truncate the file and is not
changed.

Fixes: 41e8f85a75fc ("f2fs: introduce F2FS_IOC_START_ATOMIC_REPLACE")
Cc: stable@kernel.org
Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 fs/f2fs/file.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a150de19b60f..ef7dc420fdde 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2597,6 +2597,11 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 
 	inode_lock(inode);
 
+	if (truncate && (IS_IMMUTABLE(inode) || IS_APPEND(inode))) {
+		ret = -EPERM;
+		goto out;
+	}
+
 	if (!f2fs_disable_compressed_file(inode) ||
 			f2fs_is_pinned_file(inode)) {
 		ret = -EINVAL;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
