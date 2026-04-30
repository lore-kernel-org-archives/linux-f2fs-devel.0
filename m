Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F98AFF886F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 30 Apr 2026 05:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GLuIb7qjGNsyAOwr6SIZGR2gLaLgWVE2yVlLv/8aycs=; b=LqY1aqjIBfYZDPMyI8p/F+RDVJ
	AZihmz5b3DDLQ3mm55n1RMrEen5DsSYYvUnEb5TP3fs2B0/zJZGpob7rAv9lCUeRhSG/HnQc7tExx
	fok5hZFIPiPBCpOmYLVkT9Bg+N99UnISWK2NtcmsgYdvadz6M2MUNmke2P/cLOzrrxNg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wIKDN-0006U8-Fv;
	Thu, 30 Apr 2026 05:45:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <rob_garcia@163.com>) id 1wIKDL-0006Ty-Gm
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 30 Apr 2026 05:45:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FBXdC8x39rdm+ZF4JIg2SdBeND8tL5JYlbzGM3qq5Ls=; b=Is3wQ/1UaacL0s4aX7+NIwd4sc
 Lp3sVqs8nZRs+itvlTogcCVpRytZhpD2aHQCH9vBXaB048Lf/vrgU4a3cNaK9HN+o3xHmN6eUkPi+
 Q9X8JQzsGitai+1BFPe1Vn0Q7OUerH28W2yd9hIM7zGbJwVdsuFyVVMa6UzeaCun9KNA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FBXdC8x39rdm+ZF4JIg2SdBeND8tL5JYlbzGM3qq5Ls=; b=T
 hzRg+W4DZqyk0HZq5GpbnqDSH46EWLbH/7L6505uHHnOww0gqZMI0xq86oO2cedBf2IMI8Xavx/y2
 nhhjqTlesgfe6rfnr3cLfUiM+AHW26boD5jwcbN7OxfOFlUwNeXvOcxnComAfE1Y1qplT5vz0Cpwg
 ye55UgAwYXwnuS54=;
Received: from m16.mail.163.com ([220.197.31.3])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wIKDK-0003dv-3X for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 30 Apr 2026 05:45:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=FB
 XdC8x39rdm+ZF4JIg2SdBeND8tL5JYlbzGM3qq5Ls=; b=VXf74vt+OAbJMVevJa
 aOAhOUdUu05th8BzRijyA5W0GYDN/w3urofZrZF5NS5zeFemuiIsN92sdZdQoIn4
 EqsRAvPVSgc+ao3NZ3oPAT9Ua3Ry5ThlEeuAkYPpUBOP/UA/tbXbuIYGohUgxTni
 xElYbqe/oCu4T09jwiLQ3nY2s=
Received: from pek-lpg-core5.wrs.com (unknown [])
 by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id
 _____wCXHsFm7PJpm_YrCg--.30797S2; 
 Thu, 30 Apr 2026 13:45:10 +0800 (CST)
From: Robert Garcia <rob_garcia@163.com>
To: stable@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Date: Thu, 30 Apr 2026 13:45:10 +0800
Message-Id: <20260430054510.2001015-1-rob_garcia@163.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-CM-TRANSID: _____wCXHsFm7PJpm_YrCg--.30797S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Kw1rtF15Cw13GrWxAr4ruFg_yoW8KryxpF
 13Jas8GrW8Wrn7Wws7GF1j9FyrG3y8Wr17GrZ3u3WIvw1avr1Fqr1ktw1jqF1rJrykuF43
 ZFn7CFy8Cw4DZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0z_89NAUUUUU=
X-Originating-IP: [60.247.85.88]
X-CM-SenderInfo: 5uresw5dufxti6rwjhhfrp/xtbDAgZr1mny7GbiCQAA3D
X-Headers-End: 1wIKDK-0003dv-3X
Subject: [f2fs-dev] [PATCH 6.6.y] f2fs: fix to detect potential corrupted
 nid in free_nid_list
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
Cc: Robert Garcia <rob_garcia@163.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

[ Upstream commit 8fc6056dcf79937c46c97fa4996cda65956437a9 ]

As reported, on-disk footer.ino and footer.nid is the same and
out-of-range, let's add sanity check on f2fs_alloc_nid() to detect
any potential corruption in free_nid_list.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Robert Garcia <rob_garcia@163.com>
---
 fs/f2fs/node.c          | 17 ++++++++++++++++-
 include/linux/f2fs_fs.h |  1 +
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 133141f10d94..586a90643ddd 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -27,12 +27,17 @@ static struct kmem_cache *free_nid_slab;
 static struct kmem_cache *nat_entry_set_slab;
 static struct kmem_cache *fsync_node_entry_slab;
 
+static inline bool is_invalid_nid(struct f2fs_sb_info *sbi, nid_t nid)
+{
+	return nid < F2FS_ROOT_INO(sbi) || nid >= NM_I(sbi)->max_nid;
+}
+
 /*
  * Check whether the given nid is within node id range.
  */
 int f2fs_check_nid_range(struct f2fs_sb_info *sbi, nid_t nid)
 {
-	if (unlikely(nid < F2FS_ROOT_INO(sbi) || nid >= NM_I(sbi)->max_nid)) {
+	if (unlikely(is_invalid_nid(sbi, nid))) {
 		set_sbi_flag(sbi, SBI_NEED_FSCK);
 		f2fs_warn(sbi, "%s: out-of-range nid=%x, run fsck to fix.",
 			  __func__, nid);
@@ -2603,6 +2608,16 @@ bool f2fs_alloc_nid(struct f2fs_sb_info *sbi, nid_t *nid)
 		f2fs_bug_on(sbi, list_empty(&nm_i->free_nid_list));
 		i = list_first_entry(&nm_i->free_nid_list,
 					struct free_nid, list);
+
+		if (unlikely(is_invalid_nid(sbi, i->nid))) {
+			spin_unlock(&nm_i->nid_list_lock);
+			f2fs_err(sbi, "Corrupted nid %u in free_nid_list",
+								i->nid);
+			f2fs_stop_checkpoint(sbi, false,
+					STOP_CP_REASON_CORRUPTED_NID);
+			return false;
+		}
+
 		*nid = i->nid;
 
 		__move_free_nid(sbi, i, FREE_NID, PREALLOC_NID);
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index b9affa64b7fa..fed8bec024db 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -77,6 +77,7 @@ enum stop_cp_reason {
 	STOP_CP_REASON_UPDATE_INODE,
 	STOP_CP_REASON_FLUSH_FAIL,
 	STOP_CP_REASON_NO_SEGMENT,
+	STOP_CP_REASON_CORRUPTED_NID,
 	STOP_CP_REASON_MAX,
 };
 
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
