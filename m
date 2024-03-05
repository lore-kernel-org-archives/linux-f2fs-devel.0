Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 350BDC54E41
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  5 Mar 2024 10:16:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rhRqx-0003uk-82;
	Tue, 05 Mar 2024 10:16:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <eugen.hristev@collabora.com>) id 1rhRqu-0003uc-V8
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 05 Mar 2024 10:16:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ih2S6pyJj+FNOX2FaVqCPxiJGRm/mQyzBzMM/MkTjGU=; b=iD3i4HdRdK/1YtdmPm6XewZNZ1
 73tOGSen6DbwiYKqQslZZVpFgN3qbd1L45V2OpVYdZhF6HfsvDEzCaZjtMsNqZ8r49D7BVtGuoxbr
 t9WHatoqcSwtIZ9E5L/qODwXCy2y7AXxiDZ5J1U+UjKdk9NxLelvYZQ/JBmRStPci8VU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ih2S6pyJj+FNOX2FaVqCPxiJGRm/mQyzBzMM/MkTjGU=; b=amviVxRc9VvHGrr+TUrpoFGPeV
 JnuzxH9exdfV7dFubPsRLxkUj2kdoogk6RKOYyhJdXyyeySl/Cf0gybLWlu/s6kAsTo5Xmfb6GiRJ
 nblSS/L4ggIjZtT4hfXI/zHbQJAfj1uGWOcg7aq2qLO2iWA7fkObrCd1nLGtDTFFO32I=;
Received: from madrid.collaboradmins.com ([46.235.227.194])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rhRqo-0001wD-4y for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 05 Mar 2024 10:16:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1709633806;
 bh=3qqbmy6OIcOoO07cO28FmCqjE206p+74Pkl9CCe0L8Q=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=gxoYNSJi0I9uZG/LknNNer/18SKS83gHTYykNp9drG77FRBDVO4ZGoPW1KXCCtBsG
 9p9OU37urWJRvNZRHIeVtD8klLfbZILB/pxnSYgrPxWkxpDMrgqJXtV5C/sZPg57PK
 nrrAWbGrQumnkepWliPLo+/hxxQ7QsSmzXI3BSprj7YMUhelyExDKooulmMkUVqVOX
 dqBc/NA3YUttD0CtJ+zruSi2Fc3fCpk/v37R8X76b49g+LQi8vxGT1uxHevWL+80/L
 UHIgjslt5DSP5DYPs5sZpo7o5W4j3bbGeyzuqZVNS/inhUZwEl2GS8n5aSo5GzrpNa
 zbTUhBmgbOBdg==
Received: from eugen-station.domain.com (cola.collaboradmins.com
 [195.201.22.229])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: ehristev)
 by madrid.collaboradmins.com (Postfix) with ESMTPSA id 9DF8237820D0;
 Tue,  5 Mar 2024 10:16:42 +0000 (UTC)
To: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 jaegeuk@kernel.org, chao@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org
Date: Tue,  5 Mar 2024 12:16:05 +0200
Message-Id: <20240305101608.67943-7-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240305101608.67943-1-eugen.hristev@collabora.com>
References: <20240305101608.67943-1-eugen.hristev@collabora.com>
MIME-Version: 1.0
X-Headers-End: 1rhRqo-0001wD-4y
Subject: [f2fs-dev] [PATCH v13 6/9] ext4: Log error when lookup of encoded
 dentry fails
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
From: Eugen Hristev via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eugen Hristev <eugen.hristev@collabora.com>
Cc: krisman@suse.de, brauner@kernel.org, jack@suse.cz,
 linux-kernel@vger.kernel.org, eugen.hristev@collabora.com,
 viro@zeniv.linux.org.uk, kernel@collabora.com,
 Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Gabriel Krisman Bertazi <krisman@collabora.com>

If the volume is in strict mode, ext4_ci_compare can report a broken
encoding name.  This will not trigger on a bad lookup, which is caught
earlier, only if the actual disk name is bad.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
 fs/ext4/namei.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 2d0ee232fbe7..3268cf45d9db 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1477,6 +1477,9 @@ static bool ext4_match(struct inode *parent,
 			 * only case where it happens is on a disk
 			 * corruption or ENOMEM.
 			 */
+			if (ret == -EINVAL)
+				EXT4_ERROR_INODE(parent,
+					"Directory contains filename that is invalid UTF-8");
 			return false;
 		}
 		return ret;
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
