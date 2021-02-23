Return-Path: <SRS0=ADZO=HZ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D1ACC433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 23 Feb 2021 12:07:02 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D685F64E25
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 23 Feb 2021 12:07:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D685F64E25
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mykernel.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lEWSy-0002Ci-KI; Tue, 23 Feb 2021 12:07:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <cgxu519@mykernel.net>) id 1lEWSu-0002CU-IK
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 23 Feb 2021 12:06:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Date:Subject:Message-ID:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TWNfz4sDlniyn31QVuNaYeYaL4YAuhLiiKz7tjBN9Bw=; b=StoIePwIAo4tpAoYOnLPZjPRpA
 sjyl4cin5jV98tzPuAKgmtXvOL6fW9EWOR8NJEY5vDgBDd+qpycdL88M9akQahk1vv5OLGiQw1ahU
 NIuTa2Kcd02+SzTijFOceC2koYKUf7171Y4DSxKgYiK3PEQN9sJEm9SSZPGbsWRZXoMU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Date:Subject:
 Message-ID:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TWNfz4sDlniyn31QVuNaYeYaL4YAuhLiiKz7tjBN9Bw=; b=QduPH+TNi/v5xZlC5GiaexkNyd
 YX2xlM1rYR1p00/t+oHiGYY5z3fE09LGfXKrie1UR9KkOZvNuHAKoVMOeF/Yn+XitOyzMQ06wwnzI
 ZbZPYyOwohKlv8yu7pDDz/BHPb6JU2o+V86CAgIeBlY4dOD1fD/lEp2RBDsQbbesU6EA=;
Received: from sender2-op-o12.zoho.com.cn ([163.53.93.243])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1lEWSi-002QbB-9R
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 23 Feb 2021 12:06:55 +0000
ARC-Seal: i=1; a=rsa-sha256; t=1614081046; cv=none; d=zoho.com.cn; s=zohoarc; 
 b=O3+k2Yor5f5KvOsEkWzmKGdXh19+fdgKE9ObXBp2c8Yy9BeUMcL4lH0/0sruM3t/vh4gX20xLkUBbaPZcFG3+cDVIQyDKzntYM55CUbme6Ixk6oRtT5ylEZPZz35PXeZj6HMQdam/t3l0uRFuxcFM99IV++FycGy533cNjRV3jw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zoho.com.cn;
 s=zohoarc; t=1614081046;
 h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To;
 bh=TWNfz4sDlniyn31QVuNaYeYaL4YAuhLiiKz7tjBN9Bw=; 
 b=OMaWUv6qTNb8b07hjPE9w2lbyVs0mQhk7lgzwW/UUPhAtWj7mu4ljEDtZpccekOcbBfrASQnX/HgPCTp2QUAWwf4sRhxeohFnENxL6H6eYQdyTtimIYxl651plO+DW2VctviLwp+oYWx7KWASUc7D8EglepuyVPRWn6ISAjqI68=
ARC-Authentication-Results: i=1; mx.zoho.com.cn;
 dkim=pass  header.i=mykernel.net;
 spf=pass  smtp.mailfrom=cgxu519@mykernel.net;
 dmarc=pass header.from=<cgxu519@mykernel.net>
 header.from=<cgxu519@mykernel.net>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1614081046; 
 s=zohomail; d=mykernel.net; i=cgxu519@mykernel.net;
 h=From:To:Cc:Message-ID:Subject:Date:MIME-Version:Content-Transfer-Encoding:Content-Type;
 bh=TWNfz4sDlniyn31QVuNaYeYaL4YAuhLiiKz7tjBN9Bw=;
 b=C14G1ntAVwfZsuEPqHS6rRa3cQJa228o9u3SNL4twLz8ABvQyzQbqVuGGKNxMMhX
 guzeV9IUsUEYOKetZF1sfBpdG4ZIMiOlxQaJg8UVghWapd/e6T6DMI9tTuNYITp9iFg
 FC0XzKZYokq3upx1ejhHzR25PeLQZMTIFrokz91o=
Received: from localhost.localdomain (159.75.42.226 [159.75.42.226]) by
 mx.zoho.com.cn with SMTPS id 1614081045341731.5224277504736;
 Tue, 23 Feb 2021 19:50:45 +0800 (CST)
From: Chengguang Xu <cgxu519@mykernel.net>
To: jaegeuk@kernel.org,
	chao@kernel.org
Message-ID: <20210223115016.2183798-1-cgxu519@mykernel.net>
Date: Tue, 23 Feb 2021 19:50:16 +0800
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
X-ZohoCNMailClient: External
X-Headers-End: 1lEWSi-002QbB-9R
Subject: [f2fs-dev] [PATCH] f2fs: fix to use per-inode maxbytes in
 f2fs_fiemap
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
Cc: Chengguang Xu <cgxu519@mykernel.net>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

F2FS inode may have different max size,
so change to use per-inode maxbytes.

Signed-off-by: Chengguang Xu <cgxu519@mykernel.net>
---
 fs/f2fs/data.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b9721c8f116c..b330c6a27b14 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1838,6 +1838,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	int ret = 0;
 	bool compr_cluster = false;
 	unsigned int cluster_size = F2FS_I(inode)->i_cluster_size;
+	loff_t maxbytes;
 
 	if (fieinfo->fi_flags & FIEMAP_FLAG_CACHE) {
 		ret = f2fs_precache_extents(inode);
@@ -1845,6 +1846,10 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			return ret;
 	}
 
+	maxbytes = max_file_blocks(inode) << F2FS_BLKSIZE_BITS;
+	if (len > maxbytes || (maxbytes - len) < start)
+		len = maxbytes - start;
+
 	ret = fiemap_prep(inode, fieinfo, start, &len, FIEMAP_FLAG_XATTR);
 	if (ret)
 		return ret;
-- 
2.27.0




_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
