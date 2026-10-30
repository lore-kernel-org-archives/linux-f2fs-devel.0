Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979D6606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 Oct 2026 07:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Z3S1pYyq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bueKxnXE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=kfNQpKAH;
	dkim=neutral header.d=foxmail.com header.i=@foxmail.com header.a=rsa-sha256 header.s=s201512 header.b=oP7JFeMz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Date:To:From:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=KNmeD9YzhoS1zMziLHdzTD5Sm3iTeqNPb2PDCfOMACY=; b=Z3S1pYyqSWee5vCs5FYjtpb7kE
	PdCCNdoAOzHgXEl1HDsD+X177S0krNVUCsiEFYmR4Bk/yjDPEfQm6KXK/lvlPIz6wvj5gWoK5J3GL
	9XubZC8Cw6t/UKVzDstPnq5xXwrMXI9GJHoJPF44oc17qATYz/jew5tZsJVYjVuLOLZg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xMhJq-000000008Vj-3vV2;
	Fri, 30 Oct 2026 07:46:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <treebacker@foxmail.com>) id 1xMhJo-000000008Vc-3G4Y
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 07:46:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Date:Subject
 :Cc:To:From:Message-ID:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f6hSTVr503+xmAIVsp1Ae9a/mr3a7mKY8k2VZgMpr+g=; b=bueKxnXE81i+53e74Nd2aokGqT
 KwT4ZSpukGKRX7nbohKz570QgIucTo5YPmQbvWI1IiNSaOc9+wEhmn3wxJsqSFUU6mudFgMX52jq9
 uEHE8562ZFK++HNVk4nIn5IHHmyD6WgYZrE+7EBuXMxBDNqEC5r7j4j5a0PQFVeFdLsc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc:To:From:Message-ID
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=f6hSTVr503+xmAIVsp1Ae9a/mr3a7mKY8k2VZgMpr+g=; b=kfNQpKAH7VN8xR9Sp/UFQq/P3p
 K4fcN6R8aPy0zsDUReDeIAMPdwlsgEw9DuPBcd6hOcKuoj6L5GB33cRwnR91teHjgSX67oLwlQvMK
 AFn1hEisrruThGHXM6vXo7no8s/cELzHBpkdzetfQmsqEpYLyWcclr4ttz04tK9932WM=;
Received: from out203-205-221-192.mail.qq.com ([203.205.221.192])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMhJm-000000007mm-2NMx
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 07:46:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
 s=s201512; t=1793346382;
 bh=f6hSTVr503+xmAIVsp1Ae9a/mr3a7mKY8k2VZgMpr+g=;
 h=From:To:Cc:Subject:Date;
 b=oP7JFeMzlzYXelUSjf/kxNzTbvm9DEqQ/v+CsvjTRwaRzZIoZE6jnZMEBTlRAfM7R
 IF7MIrHhjdHs6+Aws4qkXLRzjYYdW+cT1wcDEy0UlwcCwyog17Z94pXtpyvS3AoFNV
 qSaqK2rmwYn51neXsQVsYoFCk/0/tNO3U2cS1TAw=
Received: from HAPYCAO-MC1.tencent.com ([101.226.143.247])
 by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
 id 7A899E33; Fri, 30 Oct 2026 15:30:40 +0800
X-QQ-mid: xmsmtpt1793345440tzby8u61l
Message-ID: <tencent_13F84AEDEBCC170BE121ADA2D44EA69CEA07@qq.com>
X-QQ-XMAILINFO: MHMEtxMLMqJxsWMD/aMU0npTSqh8V45E639L0BYQrjACCYD0JomrwHkQ2IFNsH
 hM6a3f+PpasIbjmzf/+FBmQiY25ER9WTNd3eg2y0hqmfVsNf2gdK4eSr9NJ9egMWOFF9iL+7MeN4
 tChVGwxEhPZUJU/CCcudNcrgdk7vHB26MMTPirgdVX4sjaGIhvMgsgRjkkdyXP2TZ5Xhu5085QkM
 a/17MAuxc9uWhkWzj5K7d3WTjQvgCh8oGRRtNx1vy8CKWjAqMB21/V9gYE4jbXf7TYDWqIGBD9ou
 rlVM1/TFF2U+M21Reb8KpU2aRxgB/E2fGHkJuwFYEfSQ77lO4+ixH2ciHpXT6QGUZ7r0auUi7lth
 BqUEpO8gLb5NKwSLfSh7QmDErpmud/k90matkEBJPsj/eDl0FgFtCD7pWvd3taxNy+EyRYHW+Ql8
 aEjsXXPe2WV6yfvjeflLJUlWIES+l1O3WZQMDJ8MYRXuzuJUK0J8iG8xWx5iqUYewXk5K8tKQ7V2
 sEalmpiSxI9nKmxavlxmYfQue+IYDRmtg8nGOT6sW9oHbh8jAADYNNOKjXUzng91yRmzz3HXbefQ
 qkTKKZL15g8CIsl6dyzhIi9G3fQOhNJc1Lz60vE8qTNLzSpOr6gxE6cjnST540d6l+ks6EqAj8QY
 3OWQQGnIJts1C//daz4Z9E+MLqTiVoDSBgJzpWxY0tis7YENjyODb694hAP9TnEx7WLUx/Fx+jVg
 3axjQ9EiVwwelOBRKY8YURD43M1jp++2XjmeXrCHW1JOmVLSQ/CT9TTIdsfxsOLBmgBsY1gGPY2m
 vw9XWMOSg+TWvXqHKQW1a8qm/cHOyKv2/CjkeSbEuCN1u52pGXm9LmzlvAfzLrcE+ShJnX/Ripug
 B17gQiHAJNaQMhIWExk6J8Cve0cNMfiQ3U119spxqSxe/KCzXY3NIPOavcSwZO6lO4FcmDYnDy8f
 FOJHKZIU+OmexVjn+HratjlQY3VEtomsypQhiyIR9FWIbsnOgvPB003a8YEPK/smHB1qLzYOxu0H
 1xLuTocb82MKCkMaCBaNySDCHiKVu2uf/G56sGoOwFBtxZdllItQ9lx7EkorKEzZawFqJ9PaqJAP
 8WSd028w0ZxyM0rkWj/P6n0mD4A3abDbzIqggn7QFMALV2mNyE3KKTil9YZX7J1ihuq5XPcjSaIA
 TGrLYVsu21ewLiHg==
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: bo cao <treebacker@foxmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 30 Oct 2026 15:30:40 +0800
X-OQ-MSGID: <20261030073040.83304-1-treebacker@foxmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMhJm-000000007mm-2NMx
Subject: [f2fs-dev] [PATCH] f2fs: disallow size-changing truncation on
 atomic files
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: daeho43@google.com, jaegeuk@kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

ftruncate() (and open() with O_TRUNC) does not go through ->write_begin,
so it bypasses the COW inode and modifies the original inode directly:
it updates i_size and releases the original inode's blocks in
[new_size, old_size) while the file is in atomic write mode.

06dfe4a7eb69 ("f2fs: disallow mmap write and data-modifying fallocate on
atomic files") rejected mmap stores and data-modifying fallocate for
exactly this reason, but the truncation path slipped through: the
ATTR_SIZE branch of f2fs_setattr() has no f2fs_is_atomic_file() check
(compression, device aliasing and pinned files are all checked there,
but not atomic).

Consequences observed with a reproducer (Ubuntu 7.3.0-9-generic, arm64):
fill [0, 1MB) with a non-zero per-page pattern (page pg filled with
the byte (pg | 0x50), so page 24 reads 0x58), fsync, and verify the
baseline: 946176 non-zero bytes in [100KB, 1MB).  Then
F2FS_IOC_START_ATOMIC_WRITE, rewrite [100KB, 1MB) with the byte 0xB1
(goes to the COW inode), then ftruncate(fd, 100KB).  The
ftruncate succeeds (it is not rejected) and:

- On F2FS_IOC_ABORT_ATOMIC_WRITE, f2fs_abort_atomic_write() restores
  i_size to fi->original_i_size (1MB) while the blocks in
  [100KB, 1MB) have already been released.  Note that
  f2fs_i_size_write() skips f2fs_mark_inode_dirty_sync() and
  FI_AUTO_RECOVER for atomic files, further persisting the damage.

- On F2FS_IOC_COMMIT_ATOMIC_WRITE, __f2fs_commit_atomic_write()
  computes the commit length from the truncated i_size_read(inode)
  (25 pages) and silently drops the 231 dirty COW pages beyond it,
  breaking the all-or-nothing atomicity.

Reproducer output:

  abort:   i_size=1048576, nonzero bytes in [100KB,1MB): 946176 -> 0,
           fiemap@100KB: no extent
  commit:  i_size=102400, range [100KB,1MB) past EOF, 231 dirty COW
           pages silently dropped, first 25 pages of original data intact

After the abort, the final state of the file can be verified directly
with stat and hexdump:

  $ stat /tmp/a12-mnt/f
    File: /tmp/a12-mnt/f
    Size: 1048576         Blocks: 200        IO Block: 4096   regular file
  Device: 7,0     Inode: 4           Links: 1

  $ hexdump -s 0x18ff0 -n 0x30 /tmp/a12-mnt/f
  0018ff0 5858 5858 5858 5858 5858 5858 5858 5858
  0019000 0000 0000 0000 0000 0000 0000 0000 0000
  *

stat: the inode claims Size=1048576 (1MB) but holds only
Blocks=200 * 512B = 100KB of physical blocks.  hexdump: 0x18ff0 is the
tail of page 24, the last live page (its pattern byte is 0x58 =
pg24|0x50); from 0x19000 (= 100KB exactly) the file reads as zeros.
The boundary falls exactly at 100KB -- 924KB of data silently gone,
with no extent behind it.

Note that the file is not sparse: the [100KB, 1MB) range was filled
with non-zero patterns, fsync'ed, and read back (946176 non-zero
bytes) before the atomic write started.  The zeros after the abort
are lost data, not holes -- unlike a sparse file, where the extent
table legitimately records never-written ranges as holes.

The committed file shows the mirror-image damage: every step succeeds
(the 231 pwrites, the ftruncate, the commit ioctl), yet the file ends
up identical to one that was never written to beyond 100KB:

  $ stat /tmp/a12-mnt/f2
    File: /tmp/a12-mnt/f2
    Size: 102400          Blocks: 200        IO Block: 4096   regular file
  Device: 7,0     Inode: 6           Links: 1

  $ hexdump -s 0x19000 -n 0x100 /tmp/a12-mnt/f2
  0019000
  (no output -- 0x19000 is exactly EOF; the range does not exist)

Found by extracting the invariant of 06dfe4a7eb69 and diffing all 24
f2fs_is_atomic_file() call sites (none in the setattr/truncate path)
against operations that modify the original inode while bypassing
->write_begin; ftruncate() is the only uncovered entry point.  The
analysis was assisted by an LLM and confirmed at runtime by the
reproducer above.

Reject size-changing truncation on atomic files, mirroring the
fallocate check added by 06dfe4a7eb69.  Return -EOPNOTSUPP like
fallocate does.  f2fs_setattr() covers ftruncate(), truncate() and
open(O_TRUNC) alike.

Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/linux-f2fs-devel/20261010024133.2444761-1-daeho43@gmail.com/
Signed-off-by: bo cao <treebacker@foxmail.com>
---
 fs/f2fs/file.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index e2c0f5083313..5ed1f3176f70 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1165,6 +1165,9 @@ int f2fs_setattr(const struct mnt_idmap *idmap, struct dentry *dentry,
 			F2FS_BLK_TO_BYTES(sbi, fi->i_cluster_size)))
 			return -EINVAL;
 
+		if (f2fs_is_atomic_file(inode))
+			return -EOPNOTSUPP;
+
 		if (f2fs_is_pinned_file(inode)) {
 			/*
 			 * It may break section-aligned fallocate recovery
-- 
2.39.5 (Apple Git-154)



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
