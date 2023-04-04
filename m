Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B138DC77B62
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Apr 2023 14:55:49 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pji4a-0003oy-V5;
	Tue, 04 Apr 2023 14:55:49 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@redhat.com>) id 1pji4Y-0003oR-HZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Apr 2023 14:55:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yhiCGxChrVJlRUkYdDGuEzFvZQCsRtVvsPA45L+6JnY=; b=aIz92nFPkyHrfFmZy+vzy2kNJE
 pLVi8U1yFT+m6uB0Th0hQIclbBVH3BoE+4YQdlMEu/7vR9660156ZWkG1rVAffvaw/hXocyC/1BFB
 Op71uBa49zEoIKyPMp+e3iOsvgO3Ik/WbcnwNWX79lswMOoewo8lryMQhlZwPjSx3FZw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yhiCGxChrVJlRUkYdDGuEzFvZQCsRtVvsPA45L+6JnY=; b=IpTWnU3p2MAXMGGZLQgNiom1Hg
 5icN+BX1pj1ua7D26CPDnZm6hdO58oQcOQHNUNS+pX6iflp63VSmuDpicKikkxIh1LQvfWieO+UOE
 m6/FqpFUe7/a52Q5HLQ2zHqoyV+MEVc+HkJerblePvJQ6VMDuz2l33zGJV/FsIbQsLYE=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pji4X-00Ez9e-0y for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Apr 2023 14:55:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680620139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yhiCGxChrVJlRUkYdDGuEzFvZQCsRtVvsPA45L+6JnY=;
 b=KWkIFepVGuhAA3THGcN2o0wfPA5+QjtrkbU+fvQxzt1Swck87WuF3Lmt8dp37Uyj6Rrrnu
 KxfBxIyQ3DjVhgabVFLRuTfNW09ImXQdOtpGCXPdqiAjPcBChKyk63Au4uaOzJgdRsgyQb
 7QEG3RAnoL6Zd9VdtEvT/P2w03JRCs8=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-33-y78_6hSENquAGqa2eNhbgw-1; Tue, 04 Apr 2023 10:55:37 -0400
X-MC-Unique: y78_6hSENquAGqa2eNhbgw-1
Received: by mail-qk1-f200.google.com with SMTP id
 n129-20020a374087000000b0074a2ff16363so3599549qka.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 04 Apr 2023 07:55:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680620137;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yhiCGxChrVJlRUkYdDGuEzFvZQCsRtVvsPA45L+6JnY=;
 b=5Yw53G8SArxWWrXxX0dLPyI+KiWbdytW7eRDW3TRzrLVMYY09PUm+bTOI86StPenoN
 qL9tGW0ueCP4B1XyzAdTtP0wrxZ3n3ZDIIsZaFbdqUVELQ0Br/NH4Ynkn9Y+BlY98p2W
 PK31/Qp7jYZWodeQOMCSmrbfSE92xHDJiHGotNgZOyDgBfS+XrCJM6W0ZA+26cyPp0Xz
 nV4OUHEKluQQlt+S8ycJ7cheNjVQgw6sAs7SI0nj4MrVqspw/FY2BbQfK6xxOK6s4meV
 IMoiLJsl5im59ZFp+a8g5/c2OurSn2zq9UaJED8g2Qs/U0o6hpKkYSNkx8eeHYvlJSZI
 NNpw==
X-Gm-Message-State: AAQBX9d99VkW5lgoxKtC9i+xJuBi2IiQYJ9w7WJxpXhtKtgg7HxNlIAH
 x03k1T2Vcg+LchgyvyYNA50T+xtf4lz7cyRogGZYA9LZc5C4eGDSUuyNiiSJ9X2dhZcPC40dGA6
 QbrLule0MYQsudCCEivll4tJEVYuliVOyUoBH
X-Received: by 2002:a05:6214:f05:b0:571:13c:6806 with SMTP id
 gw5-20020a0562140f0500b00571013c6806mr3972709qvb.33.1680620137280; 
 Tue, 04 Apr 2023 07:55:37 -0700 (PDT)
X-Google-Smtp-Source: AKy350Z8MfugNU6YKVlXuq75L3kQ3utmgGFoqTKtMHqOCvYgrWH2c48gYF9y20EeEoB2IWzu0Fdckw==
X-Received: by 2002:a05:6214:f05:b0:571:13c:6806 with SMTP id
 gw5-20020a0562140f0500b00571013c6806mr3972665qvb.33.1680620136915; 
 Tue, 04 Apr 2023 07:55:36 -0700 (PDT)
Received: from aalbersh.remote.csb ([109.183.6.197])
 by smtp.gmail.com with ESMTPSA id
 j4-20020ac86644000000b003e6387431dcsm3296539qtp.7.2023.04.04.07.55.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Apr 2023 07:55:36 -0700 (PDT)
From: Andrey Albershteyn <aalbersh@redhat.com>
To: djwong@kernel.org, dchinner@redhat.com, ebiggers@kernel.org,
 hch@infradead.org, linux-xfs@vger.kernel.org, fsverity@lists.linux.dev
Date: Tue,  4 Apr 2023 16:53:13 +0200
Message-Id: <20230404145319.2057051-18-aalbersh@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230404145319.2057051-1-aalbersh@redhat.com>
References: <20230404145319.2057051-1-aalbersh@redhat.com>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Headers-End: 1pji4X-00Ez9e-0y
Subject: [f2fs-dev] [PATCH v2 17/23] xfs: initialize fs-verity on file open
 and cleanup on inode destruction
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
Cc: linux-ext4@vger.kernel.org, agruenba@redhat.com,
 damien.lemoal@opensource.wdc.com, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, rpeterso@redhat.com, xiang@kernel.org,
 jth@kernel.org, linux-erofs@lists.ozlabs.org,
 Andrey Albershteyn <aalbersh@redhat.com>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

fs-verity will read and attach metadata (not the tree itself) from
a disk for those inodes which already have fs-verity enabled.

Signed-off-by: Andrey Albershteyn <aalbersh@redhat.com>
---
 fs/xfs/xfs_file.c  | 8 ++++++++
 fs/xfs/xfs_super.c | 2 ++
 2 files changed, 10 insertions(+)

diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 705250f9f90a..947b5c436172 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -31,6 +31,7 @@
 #include <linux/mman.h>
 #include <linux/fadvise.h>
 #include <linux/mount.h>
+#include <linux/fsverity.h>
 
 static const struct vm_operations_struct xfs_file_vm_ops;
 
@@ -1169,9 +1170,16 @@ xfs_file_open(
 	struct inode	*inode,
 	struct file	*file)
 {
+	int		error = 0;
+
 	if (xfs_is_shutdown(XFS_M(inode->i_sb)))
 		return -EIO;
 	file->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC | FMODE_BUF_WASYNC;
+
+	error = fsverity_file_open(inode, file);
+	if (error)
+		return error;
+
 	return generic_file_open(inode, file);
 }
 
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index d6f22cb94ee2..d40de32362b1 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -46,6 +46,7 @@
 #include <linux/magic.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
+#include <linux/fsverity.h>
 
 static const struct super_operations xfs_super_operations;
 
@@ -667,6 +668,7 @@ xfs_fs_destroy_inode(
 	ASSERT(!rwsem_is_locked(&inode->i_rwsem));
 	XFS_STATS_INC(ip->i_mount, vn_rele);
 	XFS_STATS_INC(ip->i_mount, vn_remove);
+	fsverity_cleanup_inode(inode);
 	xfs_inode_mark_reclaimable(ip);
 }
 
-- 
2.38.4



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
