Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C12C7EE23
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 23 May 2023 12:36:50 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q1RFx-0001vA-8j;
	Tue, 23 May 2023 12:36:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1q1RFw-0001v3-Hk
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 May 2023 12:36:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ce3I3BOGwRL+Hdq211cwYd4uNzDvT4csntX5cY9nJD8=; b=EJIujEeEnjf0apxqNAxq6ZLnsz
 E1jQr625WzaUzStPxNE9dfirZR+j+vKgJ1ilm+6WJW3FMgruJzIzDwKw8ZovbKhQHh0/kQt8Iy29W
 UM8vBLVnmwppB9cDqCGUM6D6Ze5ABa7s63bAlRSUyzxCDqBbiJndJWIxrPk8yu5DgPUk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ce3I3BOGwRL+Hdq211cwYd4uNzDvT4csntX5cY9nJD8=; b=XYodnY0Tpqu5CndhvVuE1MDa4/
 0JJCxktob4JX/5gwK3qxchPuCbCjNoiO1V6gjAuGOugxPHNruvm+1yPXoiqRy1AK5bhqPuvhYi+k9
 REGdWRjU9UaM0Dy/7r5GtQwS7a9Hq35khSkdDCUzggzd2gecqpJ7xPANv9RomGcffLZo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q1RFw-000TTO-PN for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 May 2023 12:36:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 68371631AF;
 Tue, 23 May 2023 12:36:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DC0C433D2;
 Tue, 23 May 2023 12:36:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1684845402;
 bh=bWH03AemVwult1QyGoPBgmcdG2x0RGL6Y8nlzAk1w3Y=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ZxZqkBw+sKxcgg854Ofrb7ZnOYRj/5H7qI0IeSsEVPtmNJ0D8pYEA+EnpcZ1JmAJW
 azu8X85HfGM4fN7zTrjjQ3adxkgKxoeYuFPW+uu3kPm2smAoS9LA5Wlocx7iYc2tH/
 n7SeWqxENV44SSx5ruFhhiYcObNlSqsHFKNCIQem9oIX7woYYghNjN8Uf6vgvmFdpJ
 aBvYojj9Yz/13SIVFFqXHO1AsfxSktkR3FoKLS7geQJ+WFcyrlfbXXcwrDMlS0KEkB
 Rw/ACmOSJ9KTRpxKyZslrLoeXvpDBDQgWe4E57/vs7V7jSLanWFGiw2KYfzI7ewHop
 M2Rh0afezi/AA==
Message-ID: <b39c6217-a0d3-105a-b8e9-e636b87ab46e@kernel.org>
Date: Tue, 23 May 2023 20:36:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: Chunhai Guo <guochunhai@vivo.com>
References: <20230523104059.78315-1-guochunhai@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230523104059.78315-1-guochunhai@vivo.com>
X-Headers-End: 1q1RFw-000TTO-PN
Subject: Re: [f2fs-dev] [PATCH v7] fsck.f2fs: Detect and fix looped node
 chain efficiently
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 frank.li@vivo.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/5/23 18:40, Chunhai Guo wrote:
> find_fsync_inode() detect the looped node chain by comparing the loop
> counter with free blocks. While it may take tens of seconds to quit when
> the free blocks are large enough. We can use Floyd's cycle detection
> algorithm to make the detection more efficient, and fix the issue by
> filling a NULL address in the last node of the chain.
> 
> Below is the log we encounter on a 256GB UFS storage and it takes about
> 25 seconds to detect looped node chain. After changing the algorithm, it
> takes about 20ms to finish the same job.
> 
>      [   10.822904] fsck.f2fs: Info: version timestamp cur: 17, prev: 430
>      [   10.822949] fsck.f2fs: [update_superblock: 762] Info: Done to
> update superblock
>      [   10.822953] fsck.f2fs: Info: superblock features = 1499 :
> encrypt verity extra_attr project_quota quota_ino casefold
>      [   10.822956] fsck.f2fs: Info: superblock encrypt level = 0, salt =
> 00000000000000000000000000000000
>      [   10.822960] fsck.f2fs: Info: total FS sectors = 59249811 (231444
> MB)
>      [   35.852827] fsck.f2fs:	detect looped node chain,
> blkaddr:1114802, next:1114803
>      [   35.852842] fsck.f2fs: [f2fs_do_mount:3846] record_fsync_data
> failed
>      [   35.856106] fsck.f2fs: fsck.f2fs terminated by exit(255)
> 
> Signed-off-by: Chunhai Guo <guochunhai@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
