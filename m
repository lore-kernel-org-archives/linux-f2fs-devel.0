Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76030C52D7B
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Aug 2024 01:07:12 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1se2Tn-00066K-Uy;
	Wed, 14 Aug 2024 01:07:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <eadavis@qq.com>) id 1se2Tl-00066C-MQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Aug 2024 01:07:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Date:Subject:Cc:To:From:Message-ID:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ReZ3OIVJJOOm8FhpzgeIJ1dbD9yDoTF40FYLWUq7Uvo=; b=d3E7p5eq3d24laNA6U5hP8l7Bh
 aAmPIF0cuymwMMC6VlpJKnyAI/LvhcKS3o7vPH7J5vQdwseGdDxJTP3xAs8923MX+05yi2PuMJKDm
 O+moz6tlJwvcYV+X7RnkyOmoSZ4WwsSHja8d7TRDb2VkB19GJxr7q7BkykehtznBXtYE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Date:
 Subject:Cc:To:From:Message-ID:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ReZ3OIVJJOOm8FhpzgeIJ1dbD9yDoTF40FYLWUq7Uvo=; b=XfABNh5C4JMmx+/rz7kahQoA43
 ttcYCsT3ayI7T/GaafKkRT+l22gxEHOyRng8NdzwVTpSH683Z5u7aJUvwLvqA5cj1Jl6rbdRECjiL
 mz7m5s9hAeguUst69ZVs/Mm5gXBxpq430/358XDyrZlFy0hKm8v5RBOktQqLD5ao1ECs=;
Received: from out203-205-221-164.mail.qq.com ([203.205.221.164])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1se2Tj-0008J7-F7 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Aug 2024 01:07:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1723597315; bh=ReZ3OIVJJOOm8FhpzgeIJ1dbD9yDoTF40FYLWUq7Uvo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=lhSQWOecIjGByj+5PHRg03pEDjzBYCWBerRVDfC79gr7xLyA0kAS52bZcaGMLXQfL
 YQ+/2dF594mAnSN0XMWaWwxRRT+fiL8mPr9XHpA3YwYTwWPtNhtSClMs4eLf5LwOtb
 8NIRub8P9bPvV070SxnLTQF172in2PtVIC6Z+B78=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
 by newxmesmtplogicsvrszc5-2.qq.com (NewEsmtp) with SMTP
 id C273AAD5; Wed, 14 Aug 2024 08:48:39 +0800
X-QQ-mid: xmsmtpt1723596519tk48o1yxq
Message-ID: <tencent_E51B7925E5BAF4BBCF33739E5E1BFA4B9F08@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTquzbZ/8GSd2fAmi23hj0naTp7q5gZW9S0I57UXV636KKcIAkjp
 U1T587HOkaeks4nDPFBfeI5oJY8v+H7WNBQXsXZKZZW6VEzBOymP0EbzmPbCAmcnL/NVHKT0eQ5J
 Wc7WsOeMwUJjnTVzdnyBM14qxqI6+QDmaR/0dakeNequ5dB5M58kmDkebDvJINuY/jPbhTULxu/e
 qHxbbmyA1+zvP8oUTiKXU4gpO1ePrqDa5NauKGf7Bu6MHuW9PXjdNsVI9QtFFNv5qGRP8+9nn3sB
 MAvVp82qwB8XKN5ctdkVypFPx79uaHBgH0/93IMOMC5TNGv13kFe4cv8WcZsRtXn7Ecbo2qvGzXr
 qvWHmKcH5X3K5VlugL1TNayaSctvwg0K3UaBkMGXlEZ4tTlvrqse78JgQm0VzkNWyRKVQxRMFKPT
 Hu349V60O7E3uYTV/6Ihpnslc/4jY9fNHcql3sas1HtkOc3ON4nnrkpOk1EimyqS+547SEu44jLW
 yeyJQnZehVZCUQXT+5GRDfyOG9fDmqcoIQqXhtMZ2Dpq09s4Mk5tw/b2xco6ZDc5soM/701s4XT4
 Pj/iPAVEPuGrW3AsVsP3Y+EaCqEBTH4tQbCrcCUG+pTmqiASkSBsTDnxUabOy8orLluOME3UikHR
 DXwQkJQN32ezW8J6CMgcxEN0aPXdgT49Iw+KZ88UqSwB6U+rjzw3PyY07UiMCPdjasLFIaMQ+vlq
 a3n7Ekkw1gI2dAS/f51KCAUYxS8wnhdFCFj0ELjdRklRGoAIZx1AaxJg1Acq4NJb6zFShsPtgPzj
 g9WyC7DFADyzz1HsMjLVrH//h8Af9IbwcsfMAu+et/rMTIfi2wELheEZq6uWuLc1NcjaW9iud40X
 Nt6dTIQmo5aDU2lwroN/y5uHbeVKX0yFS9LjgcsKdpw9Q10J2dTAXQBGhsLh7Y2l3peZYffdxaUT
 0IDVJIhGmnirVPxVq/Xq5MNevAnAxvNuxelzq2fi8qEB4DqrQvDw==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
To: syzbot+78ff2855f26377625419@syzkaller.appspotmail.com
Date: Wed, 14 Aug 2024 08:48:40 +0800
X-OQ-MSGID: <20240814004839.504138-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000ebae95061f96be85@google.com>
References: <000000000000ebae95061f96be85@google.com>
MIME-Version: 1.0
X-Headers-End: 1se2Tj-0008J7-F7
Subject: Re: [f2fs-dev] [syzbot] [f2fs?] WARNING: lock held when returning
 to user space in f2fs_commit_atomic_write
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
From: Edward Adam Davis via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Edward Adam Davis <eadavis@qq.com>
Cc: jaegeuk@kernel.org, syzkaller-bugs@googlegroups.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

unlock i_gc_rwsem[WRITE] before quiting f2fs_commit_atomic_write

Fixes: 7566a155c666 ("f2fs: atomic: fix to not allow GC to pollute atomic_file")
Reported-by: syzbot+78ff2855f26377625419@syzkaller.appspotmail.com

#syz test: net-next 9e6869691724

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 741e46f9d0fd..a43054ab0cf1 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -389,13 +389,13 @@ int f2fs_commit_atomic_write(struct inode *inode)
 
 	err = filemap_write_and_wait_range(inode->i_mapping, 0, LLONG_MAX);
 	if (err)
-		return err;
+		goto out;
 
 	/* writeback GCing page of cow_inode */
 	err = filemap_write_and_wait_range(fi->cow_inode->i_mapping,
 							0, LLONG_MAX);
 	if (err)
-		return err;
+		goto out;
 
 	filemap_invalidate_lock(inode->i_mapping);
 
@@ -407,6 +407,7 @@ int f2fs_commit_atomic_write(struct inode *inode)
 	f2fs_unlock_op(sbi);
 
 	filemap_invalidate_unlock(inode->i_mapping);
+out:
 	f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
 
 	return err;



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
