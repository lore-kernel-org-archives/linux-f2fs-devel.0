Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 529BAC02198
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Feb 2025 03:39:09 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ti3ad-000492-Et;
	Wed, 12 Feb 2025 03:39:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ti3ac-00048o-5k
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Feb 2025 03:39:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fSCLQ+/3Hsj9zPkm9JLrDfqX6mWXMMmLr3LE4wJ8w4I=; b=liTC93UoFSqLk+38mzekf0T2e1
 hc2Q2PZdOXnjeMJZrOvI7BBPf4M1r7UUxKG9dJzBOAnWtwwhOXZzHZpZgvq8IfQwEULcAV2MuI/Bu
 82LGci36ta37B3d2LN8z5b2bE58FhUa47mSbIaCbWfcRyT2OepjfVw0sZut1Ci3HiiT0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fSCLQ+/3Hsj9zPkm9JLrDfqX6mWXMMmLr3LE4wJ8w4I=; b=E6qqOJXWo35H+D3KsyyMezJHFL
 GdgDGnTSPJUvov5Uy6v9K6eZPkMMjyP7NO4/ZrpL7XcnZfoByxsKd+ApE3ILlreCiyqhnV9hz1GKZ
 PUJTFNLfd2RYy28JPDn+OQwoBYc1V9wD3ukdvx69n0KG2zVPCXSCvstzZQOwtv2Wza5Q=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ti3ac-0003up-7z for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Feb 2025 03:39:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 22ADEA40FA8;
 Wed, 12 Feb 2025 03:37:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37A6FC4CEDF;
 Wed, 12 Feb 2025 03:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739331535;
 bh=husLCFSe8peHA3aELneo6doulef1zDxM3wWdqYQuZcg=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=f8dvQxm5x75pnbI5BtYQER8KefmGrkXAnH7csOEZsCQIDTi5gya1apXC109NnuyO5
 V4NzWhDE3FngD7ElDipJ3fHo/15xDiUlqThBlvbMLQCtTc1EHigiKKn50op5pZrSVB
 TnMzqEsh8QRPB0coXdhtXV3ao8y8rS+/La8MB0Ya1CZPuDQO3Px11WpKBSNUDUs84K
 /td7tRCLeAjRxrtlEwdfrjWER4K8MUFKlM1wb5kPKjZiq2vL7TuugkeQ85zYNDTwd/
 rwe0dUZOIFtsMrZguFFNd9Avdh3sHObIJjRRobllVXD1M5j6cnXiCOJu6bHHcaMhII
 fgGuGv8U2gcGQ==
Message-ID: <983c13f7-7b27-43c5-ad9e-20c24aa7b3fc@kernel.org>
Date: Wed, 12 Feb 2025 11:38:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250211071725.457343-1-chao@kernel.org>
 <Z6wUaT91OnABzNfQ@google.com>
Content-Language: en-US
In-Reply-To: <Z6wUaT91OnABzNfQ@google.com>
X-Headers-End: 1ti3ac-0003up-7z
Subject: Re: [f2fs-dev] [PATCH v3 RESEND] f2fs: add check for deleted inode
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, Leo Stone <leocstone@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2/12/25 11:24, Jaegeuk Kim wrote:
> On 02/11, Chao Yu wrote:
>> From: Leo Stone <leocstone@gmail.com>
>>
>> The syzbot reproducer mounts a f2fs image, then tries to unlink an
>> existing file. However, the unlinked file already has a link count of 0
>> when it is read for the first time in do_read_inode().
>>
>> Add a check to sanity_check_inode() for i_nlink == 0.
>>
>> [Chao Yu: rebase the code]
>> Reported-by: syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com
>> Closes: https://syzkaller.appspot.com/bug?extid=b01a36acd7007e273a83
>> Fixes: 39a53e0ce0df ("f2fs: add superblock and major in-memory structure")
>> Signed-off-by: Leo Stone <leocstone@gmail.com>
>> Signed-off-by: Chao Yu <chao@kernel.org>
>> ---
>> - no logic change, just rebase the code to last dev-test branch
>>  fs/f2fs/inode.c | 6 ++++++
>>  1 file changed, 6 insertions(+)
>>
>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>> index d6ad7810df69..543fb942bec1 100644
>> --- a/fs/f2fs/inode.c
>> +++ b/fs/f2fs/inode.c
>> @@ -386,6 +386,12 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
>>  		}
>>  	}
>>  
>> +	if (inode->i_nlink == 0) {
>> +		f2fs_warn(sbi, "%s: inode (ino=%lx) has a link count of 0",
>> +			  __func__, inode->i_ino);
>> +		return false;
>> +	}
> 
> This gives a wrong EFSCORRUPTED when recoverying orphan inodes.

Correct, I noticed that it may fail generic/417, let me fix this.

Thanks,

> 
> f2fs_recover_orphan_inodes
> -> f2fs_iget_retry
>  -> orphan inode can have i_nlink = 0.
> 
>> +
>>  	return true;
>>  }
>>  
>> -- 
>> 2.48.1.502.g6dc24dfdaf-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
