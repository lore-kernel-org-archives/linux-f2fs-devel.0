Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C01C61DFD
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  2 Sep 2026 07:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FxaoskD9jcheor5a9k4/yP2cd8KUdOwO6ZQLsn2aaNk=; b=dzk4CHtVgfJxl6Ms+D4e0AK9Mw
	iGUsCDPKPxu5cQVZaBaOUYvnsyJGV45L27a+i09UAGHpM/9W5+s+v7jxVvQUGEcsO0Hhgqczmhs5l
	bBHYT/t6VngBCWk7ilM7FP3Ho1oqAaYjrt5wV4mAkFkQLHyFXTKC8seYl9pq5hnPTJk0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1fQO-0003yI-PP;
	Wed, 02 Sep 2026 07:30:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x1fQN-0003yC-0U
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 07:30:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GJhNlkUX6KPd08Vsb4016VKYf4nuO78eW1N9kEqdouM=; b=QO+jP5x/s00Kxr5YALuQI5tJjO
 L8rHsDeS3c8ObWWYqxWFahV3RKhSBmouMb+ub2Xl6sNFQTquprOLo5wRO8+Y0A3O5EgITD7ZWexW2
 Q1yjmIaDRqTuyO61AzgBfWs6r9IwnFAUf1fBHYJa6iqMdZVRBdoI6hzvnXF2ZkHpOL1g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GJhNlkUX6KPd08Vsb4016VKYf4nuO78eW1N9kEqdouM=; b=mDzO8w+BRds9RApCKrMfz9YwyW
 XznTS/KBqsI2vk1aV+EpNmON3JRDY3iYnrfiQklAVtWcTc55PbmLKlf3ZOWyoqcyf10Fl6nyfp1ir
 J0i3z7+zlZ8AY+6osu6dpG0o2dIMo/fnpkMw9PTQfoLWGAkjkUb9g1HQrl+nOsZmVdYg=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1fQL-0008N3-2i for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 07:30:23 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3895D600D0;
 Wed,  2 Sep 2026 07:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5871F000E9;
 Wed,  2 Sep 2026 07:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788334214;
 bh=GJhNlkUX6KPd08Vsb4016VKYf4nuO78eW1N9kEqdouM=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=JhUB+Uvy5v8T3KH7OViyBaP7klEVuHYO85aewfhpbNYm/Nq9ntdcZku0ImYhPj5/a
 Lxzo9xjHZUhHJcTcjWUTQelWCj+lc1P9AdBhV408C0umCfUEFKhAZGOkzo67kqxLLG
 6v3Ctfo2iiVUxnNM3LGKvAkTv15C0vPgb50riS4egjIkepsNF9e7IZqPcIOD+rTA/i
 717GYBNLNoLRjT8RCqO5SfC3irG3e6UbON59CKrzDfB+C0AN5ZrALxnx4cfBAdwvcI
 DohLowQ3KAxrlC7HMMkLiICemC+6AG2EqXppO8mJQZ3tyA4eEAfWkD4TZVP3KfCRzo
 s8+m69fzY5Gpg==
Message-ID: <afbed6d5-0c11-4041-ab8a-68f0264dceda@kernel.org>
Date: Wed, 2 Sep 2026 15:30:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260901140849.3405971-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260901140849.3405971-1-qiwenjie@xiaomi.com>
X-Headers-End: 1x1fQL-0008N3-2i
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: wait for inode record work before
 clearing ino bitmaps
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
Cc: qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/1/26 22:08, Wenjie Qi wrote:
> APPEND/UPDATE inode state recording was moved to the inode eviction
> workqueue. These entries were later converted to bitmap values stored in
> XArrays, but the workqueue drain was left behind in the list cleanup loop
> where it is now a no-op.
> 
> During unmount, inode eviction work can therefore remain queued when
> f2fs_release_ino_entry() destroys the bitmap XArrays. A delayed worker can
> repopulate them before the workqueue is finally destroyed, leaking newly
> allocated XArray nodes when the F2FS superblock is freed.
> 
> Wait for APPEND/UPDATE inode record work before destroying each bitmap
> XArray, restoring the required ordering.
> 
> Fixes: 9a9ee7408a1f ("f2fs: reduce memory footprint of ino management")
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
> ---
> v2:
> - Remove the no-op wait from the ORPHAN/FLUSH cleanup loop.
> - Wait once before bitmap XArray cleanup since APPEND/UPDATE share evict_wq.
> 
>  fs/f2fs/checkpoint.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 4b59f30ef45d5..642a771e0f63c 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -887,8 +887,6 @@ void f2fs_release_ino_entry(struct f2fs_sb_info *sbi, bool all)
>  	for (i = all ? ORPHAN_INO : FLUSH_INO; i <= FLUSH_INO; i++) {
>  		struct inode_management *im = &sbi->im[i];
>  
> -		f2fs_wait_for_inode_record(sbi, i);
> -
>  		spin_lock(&im->ino_lock);
>  		list_for_each_entry_safe(e, tmp, &im->ino_list, list) {
>  			list_del(&e->list);
> @@ -899,6 +897,8 @@ void f2fs_release_ino_entry(struct f2fs_sb_info *sbi, bool all)
>  		spin_unlock(&im->ino_lock);
>  	}
>  
> +	f2fs_wait_for_inode_record(sbi, APPEND_INO);

It may missed to wait UPDATE_INO?

Thanks

> +
>  	for (i = APPEND_INO; i < MAX_INO_ENTRY; i++) {
>  		struct inode_management *im = &sbi->im[i];
>  



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
