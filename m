Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98650606A331
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Oct 2026 09:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Qojrl+cQ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=J0pBBgs8;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ZZP1QaPu;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=crJexHtX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bzEmCrjF9XmWtWHl1l0Jac9dqrTLx1jppKWmhUOocrE=; b=Qojrl+cQAYwJdTDDlcnXbyUXRl
	B7fLpw0a2vN6Uo6shA+PlfBdW8Xm3oeijWI38IAgpMuAptn1c9Am6JiHgZuwJw5Ba38O+QZ5c5Kro
	9quZOwPq4JasBiswdBANLK+/1LO7B9EHjcy8HqoDa2eRugYk0y4b9xKnl/4SuvJayAZo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJ5wo-0001Np-JO;
	Tue, 20 Oct 2026 09:15:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xJ5wm-0001Nh-Pe
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 09:15:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pPNi6K/q4Flsi+LY1UbUim5BbaMXt4Eom1UfkYRyDKA=; b=J0pBBgs8XmVLQxvdHnkycVhn0K
 7lqLDdKOoBQTmQ2p9cawVkztF9xdKXQmPueddKl+MrdVbElIdY0C4nSM1Y7zIHv3l88swIr+aTvkk
 tQgX/FEQCNxeTpZtPkcWX8H+prUPWmRa6pJ8Q2JQ4K5HAGlHcRL/4L0I/Yq3TC+duMjI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=pPNi6K/q4Flsi+LY1UbUim5BbaMXt4Eom1UfkYRyDKA=; b=ZZP1QaPusRO2I1bhFECimnCH2E
 kSioHq7ZCwg7nO21GQQfwtGUbiA+RUEKIeUS9gV8AJim5Gbe3ZskfOKkRjsD4ceGQnjDTqT0EwmTp
 CB1xM7roWv0PkzBIeCAMQhjtQo3B06YIIwXy4Fpr8VqtuNFaQZejwIIHJbtJPVHDPoa0=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xJ5wl-0007MH-Cf for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Oct 2026 09:15:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C052E60DAA;
 Tue, 20 Oct 2026 09:15:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90EAF1F000C5;
 Tue, 20 Oct 2026 09:15:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792487745;
 bh=pPNi6K/q4Flsi+LY1UbUim5BbaMXt4Eom1UfkYRyDKA=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=crJexHtXiW28+0ceEd/l7jMkNcWiS4NiL4QSS/g4jKSWFlWD+UzSXpFxEJFBuS6C3
 iTuUIou+SFLRVl2rZ0eqilA6lzaEoJdBEoZspIm0q5KJS5W/qPoafMD5RqO6B/rH0g
 ty9Fj8QZfLPxQcNic9YMdwQvTbKgxEwIMQtjxM/TEX5kfLxNfZzh7jAtL1U6s6+H7k
 gmleBR1bjDwrs1EJcvOCWDSIGoWQQ6R9QcCQNHq6n/82BhuirzgOlMnehj3gTElws1
 UxF8yDRVuO+N4zMNXQqpVj3k2Bbx+C1nCZJbA1IiMmsyFjT828AreqTfVWeIXeqUY0
 WeeG87dq4nciQ==
Message-ID: <b82f0168-dcf4-4018-8f51-de39d02a9feb@kernel.org>
Date: Tue, 20 Oct 2026 17:15:43 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261015161714.1586334-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261015161714.1586334-1-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJ5wl-0007MH-Cf
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't use truncate_inode_pages_final()
 on live inodes
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/16/26 00:17, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> truncate_inode_pages_final() is meant to be called from ->evict_inode.
> It sets AS_EXITING on the mapping, and nothing ever clears it, to tell
> the VM that the inode is going away.
> 
> f2fs calls it in two places where the inode stays live:
> 
>  - F2FS_IOC_START_ATOMIC_REPLACE uses it to drop the page cache of the
>    original inode before setting i_size to 0. The atomic write then
>    goes on through this inode.
> 
>  - f2fs_abort_atomic_write() uses it to drop the uncommitted data. It
>    is called on eviction, but also on the last writer's close in
>    f2fs_release_file(), from f2fs_file_flush() when the atomic writer
>    exits, from F2FS_IOC_ABORT_ATOMIC_WRITE and when
>    F2FS_IOC_COMMIT_ATOMIC_WRITE fails.
> 
> Other processes may still have the file open or mapped in all of these
> cases. The mapping then stays marked as exiting for as long as the
> inode is in memory. This stops reclaim from storing workingset shadow
> entries for it and breaks any code that assumes an exiting mapping has
> no users left.
> 
> All we need in both places is to drop the page cache, so use
> truncate_inode_pages(mapping, 0) instead. The eviction path is not
> affected, because f2fs_pre_evict_inode() still calls
> truncate_inode_pages_final() after f2fs_abort_atomic_write().
> 

Cc: stable@kernel.org

> Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
> Fixes: 41e8f85a75fc ("f2fs: introduce F2FS_IOC_START_ATOMIC_REPLACE")
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
