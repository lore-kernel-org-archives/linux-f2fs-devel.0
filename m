Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11DF8C77B78
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Apr 2023 17:15:01 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pjkFJ-0000Ds-Ge;
	Tue, 04 Apr 2023 17:15:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zlang@kernel.org>) id 1pjkFH-0000DY-OE
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Apr 2023 17:14:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=438OaszGV1JxFbp4kGbcMSjEeXZZci5CJdRGLkzLkXU=; b=i3oFIP9BLHwKG5dvJJum10mriI
 EBImPVd2Ne1U+fxtlg8gky4BaOOD7vo/h1DXlv8J0mfhGuAkZg+/aAs4vS5CisyuAxbO5i6AlZwte
 BYIG82yb501W963jdfXxWJDMk17eTg5BOzJ/B4WuC0morwP1STUXqsiCKlfV5nAAOxyM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=438OaszGV1JxFbp4kGbcMSjEeXZZci5CJdRGLkzLkXU=; b=f37dW0yjD5AkSefaXy74yh1vk4
 iEUCKdO4Bbydw517U3b1vS6fgaU29w2KkQ4eGaKHSJCzSBo0+BEpHdmfaizYQlUf4r7dxO0ntAN9m
 iPJOS0sDxge5IrZbAe46zJiLQextB1RS4taajXg3woRe0cWi58dRzAtqcerpH/GYINec=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pjkFG-00F8KJ-34 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Apr 2023 17:14:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B1A826378B;
 Tue,  4 Apr 2023 17:14:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CEAC4339B;
 Tue,  4 Apr 2023 17:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680628492;
 bh=NBUCaONjYi40Vbcu4o/CCPE2N3ymcLwg1V2SlbPeNJs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mHGfLFO/6lWqvTQg3dD+ZiGLcThFJvk3b7nrRH/m3eMGcgcPfBNNFG6drzx4LOJrr
 /L6gN7acWGxiBVx7p9NtIy5ewclLB0T6z2nezlnjEKe4jCcFHpTj+cWbZfV+OPUa2n
 Iuen29mduilHjKHmQMesnJATtLYk/UwJ2N+ZcuULKiETcbcfpeRkdzP6zHKyZ13BTC
 l1QSKNjtUu7bwyO3EmM9BAGxTJOyRw/W/BmSLbpWzEP3LFtJIg1yBIIQcywBu14GE/
 x/lbszQJwhPGa/5cqaAEZXkLpxfPtRy5Ltc8ciKsMrx7HIMYtZ+fI8cOlbIdlK5RVw
 wd+gJ7j1HfZrQ==
From: Zorro Lang <zlang@kernel.org>
To: fstests@vger.kernel.org
Date: Wed,  5 Apr 2023 01:14:11 +0800
Message-Id: <20230404171411.699655-6-zlang@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230404171411.699655-1-zlang@kernel.org>
References: <20230404171411.699655-1-zlang@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1pjkFG-00F8KJ-34
Subject: [f2fs-dev] [PATCH 5/5] fstests/MAINTAINERS: add a co-maintainer for
 btrfs testing part
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
Cc: brauner@kernel.org, linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 ebiggers@google.com, djwong@kernel.org, amir73il@gmail.com,
 linux-unionfs@vger.kernel.org, anand.jain@oracle.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 fdmanana@suse.com, ocfs2-devel@oss.oracle.com, jack@suse.com,
 linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Darrick J. Wong would like to nominate Anand Jain to help more on
btrfs testing part (tests/btrfs and common/btrfs). He would like to
be a co-maintainer of btrfs part, will help to review and test
fstests btrfs related patches, and I might merge from him if there's
big patchset. So CC him besides send to fstests@ list, when you have
a btrfs fstests patch.

Signed-off-by: Zorro Lang <zlang@kernel.org>
---

Please btrfs list help to review this change, if you agree (or no objection),
then I'll push this change.

A co-maintainer will do:
1) Review patches are related with him.
2) Merge and test patches in his local git repo, and give the patch an ACK.
3) Maintainer will trust the ack from co-maintainer more (might merge directly).
4) Maintainer might merge from co-maintainer when he has a big patchset wait for
   merging.

Thanks,
Zorro

 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0ad12a38..9fc6c6b5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -108,6 +108,7 @@ Maintainers List
 	  or reviewer or co-maintainer can be in cc list.
 
 BTRFS
+M:	Anand Jain <anand.jain@oracle.com>
 R:	Filipe Manana <fdmanana@suse.com>
 L:	linux-btrfs@vger.kernel.org
 S:	Supported
-- 
2.39.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
