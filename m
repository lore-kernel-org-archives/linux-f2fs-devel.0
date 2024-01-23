Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 246E8C47DDB
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 23 Jan 2024 20:19:13 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rSNEk-00016X-9W;
	Tue, 23 Jan 2024 20:19:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <mpatocka@redhat.com>) id 1rSNEj-00016R-15
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 Jan 2024 20:19:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:MIME-Version:References:Message-ID:
 In-Reply-To:Subject:cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0XX4UE7LBcIxPzCfE5s5PrNdR9h0h9VUxg0e4qCV+gs=; b=dyQd/DYcEZcAadXAOgdIgWe/wX
 6w9JjbqjL4YAfv/iwKeVsKir0ZCEwG8euBhT3L5gufH2uA+ARbmlEoea3Tzw2n3zuY8NtU4u05165
 86WGYO1cHJ0afzoGJARyyjg1KZnYd/nezc3khCozgDJbqix9y3SN1VYYZsi4pEfN0/MQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:MIME-Version:References:Message-ID:In-Reply-To:Subject:cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0XX4UE7LBcIxPzCfE5s5PrNdR9h0h9VUxg0e4qCV+gs=; b=PUQrG2nSL/QhBQXg0aYabO966S
 koXG9i5eL+dXm/yfDeK3ZydD6oqWsho9rcRh4CVrQjUYW+hNO0Vl3zYcBmh59JzCZrcQSFZSgpS5w
 27m80FMT0oYRj5Sc8mQdzl0lhcWFLKgUIO9Q09T4lO/mz+chmAjxQwFyxDJbYNXp8eWU=;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rSNEe-0003jN-LH for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 23 Jan 2024 20:19:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706041133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0XX4UE7LBcIxPzCfE5s5PrNdR9h0h9VUxg0e4qCV+gs=;
 b=Rv7vIadqb65YoQc0xaADhZzcdaRPC6mpKgMba9DBiLVamPMcYdglweSi8ctr75DPHu3Whn
 oRoJ2GFWIUwZ0NEMJaww6u8DM0u1gcgmKkDwlsEEKJgVxa/SwT/02jyNqnY24e8DiR4Ygl
 q8A1mXgZO1088+pwTCL2aZwDXSr+tqs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-EUy2mcVyOKOCDA3_mOVAAQ-1; Tue, 23 Jan 2024 15:18:47 -0500
X-MC-Unique: EUy2mcVyOKOCDA3_mOVAAQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C176188B5BD;
 Tue, 23 Jan 2024 20:18:45 +0000 (UTC)
Received: from file1-rdu.file-001.prod.rdu2.dc.redhat.com (unknown
 [10.11.5.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7A1AB51D5;
 Tue, 23 Jan 2024 20:18:45 +0000 (UTC)
Received: by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix,
 from userid 12668)
 id 6180130A79CB; Tue, 23 Jan 2024 20:18:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by file1-rdu.file-001.prod.rdu2.dc.redhat.com (Postfix) with ESMTP id
 5BF883FB4E; Tue, 23 Jan 2024 21:18:45 +0100 (CET)
Date: Tue, 23 Jan 2024 21:18:45 +0100 (CET)
From: Mikulas Patocka <mpatocka@redhat.com>
To: Johannes Thumshirn <johannes.thumshirn@wdc.com>
In-Reply-To: <20240123-zonefs_nofs-v1-2-cc0b0308ef25@wdc.com>
Message-ID: <55226421-ce21-f769-94e0-d42c97e55e7d@redhat.com>
References: <20240123-zonefs_nofs-v1-0-cc0b0308ef25@wdc.com>
 <20240123-zonefs_nofs-v1-2-cc0b0308ef25@wdc.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Headers-End: 1rSNEe-0003jN-LH
Subject: Re: [f2fs-dev] [PATCH 2/5] dm: dm-zoned: pass GFP_KERNEL to
 blkdev_zone_mgmt
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
Cc: Naohiro Aota <naohiro.aota@wdc.com>, dm-devel@lists.linux.dev,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>,
 linux-fsdevel@vger.kernel.org, Mike Snitzer <snitzer@kernel.org>,
 Josef Bacik <josef@toxicpanda.com>, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
 Chris Mason <clm@fb.com>, Damien Le Moal <dlemoal@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net



On Tue, 23 Jan 2024, Johannes Thumshirn wrote:

> The call to blkdev_zone_mgmt() in dm-zoned is only used to perform a
> ZONE_RESET operation when freeing a zone.
> 
> This is not done in the IO path, so we can use GFP_KERNEL here, as it will
> never recurse back into the driver on reclaim.

Hi

This doesn't seem safe to me. There's a possible call chain dmz_handle_bio 
-> dmz_put_chunk_mapping -> dmz_free_zone -> dmz_reset_zone -> 
blkdev_zone_mgmt -> recursion (via GFP_KERNEL) back into the dm-zoned 
target.

Mikulas

> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  drivers/md/dm-zoned-metadata.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-zoned-metadata.c b/drivers/md/dm-zoned-metadata.c
> index fdfe30f7b697..a39734f0cb7d 100644
> --- a/drivers/md/dm-zoned-metadata.c
> +++ b/drivers/md/dm-zoned-metadata.c
> @@ -1658,7 +1658,7 @@ static int dmz_reset_zone(struct dmz_metadata *zmd, struct dm_zone *zone)
>  
>  		ret = blkdev_zone_mgmt(dev->bdev, REQ_OP_ZONE_RESET,
>  				       dmz_start_sect(zmd, zone),
> -				       zmd->zone_nr_sectors, GFP_NOIO);
> +				       zmd->zone_nr_sectors, GFP_KERNEL);
>  		if (ret) {
>  			dmz_dev_err(dev, "Reset zone %u failed %d",
>  				    zone->id, ret);
> 
> -- 
> 2.43.0
> 
> 



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
