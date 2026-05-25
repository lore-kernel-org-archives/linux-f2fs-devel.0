Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C27ECCD5BBF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 25 May 2026 07:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B1T66yw2vObE2bi9Y+kyJ6P19khG4MkfiA8z+YJElZw=; b=hrsV3lTU0WUtq1sBA5NX5AA5Ut
	FIDGjxD4P51LxnQSqU7qR9934UKCdaJPGWuhJ6kBaKTIS/+vk9QUu0+ry8G3aQ0xfvBxd3cVN4nGZ
	HVX9ITpnbNiZh6wJ5q7pnI17mMq9jDbKUbMNOXuCmdnxUuh40DjZG0f9LK7LTB+Is3Gs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wRPRg-000380-JM;
	Mon, 25 May 2026 07:09:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+728b97dfb722ff21c2bb+8310+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1wRPRf-00037p-8Y for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 25 May 2026 07:09:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=syRvi07sgur66zfha9AI/lR4MWGyK8TIBCUS+OGxqFY=; b=jZlpvu+AkY5xb6L1Yp/Mron+N1
 YPz5E227cBueWeMQSW0eIt1AKypZjT7jQCqecfo/2Osm+oBLSz8rrpZ+FoCxcgUyzBOu17RGTCPff
 gnfgPlanoc3Sxmfq7t/x610BYdUssAy6HptXUZPJAAJDU/zjuS1aPxzI2elrQEXqj9pw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=syRvi07sgur66zfha9AI/lR4MWGyK8TIBCUS+OGxqFY=; b=D7l+9ubneZzKNyQuSNMK10R4NK
 PuATtKESWp5qi306HBZ9eEPK2oRJBG8ldw6fGtjbJZJJeDIwETEUqhn1avH5JXaFRgjJsFHViKyAH
 zeEzGExW03MS5afbEnIgVrXDjvsZfYBkTjkLO01yJUvGVKoYd0Vlb0z420j1EN0zWLSQ=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wRPRe-0008B6-7L for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 25 May 2026 07:09:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=syRvi07sgur66zfha9AI/lR4MWGyK8TIBCUS+OGxqFY=; b=CUzhw2KTZ4UKg6JJLG5dangK8J
 Q3ktpouecNWzjHpJe94UQahLJxM/3Db1lfDqSytbmItYe+lMJsCCdK0MQxbSXRNhcOxAGratAzAIB
 0qy12kFFfdjr2WpaRsh08W9CXxnyKVavYJHWHVpI2mYCyKRgmORPzfWYmEGRShdtlXkMS9LqNOxvk
 3U/sNUoBt/IAFKCio2uziR0yfOwLq1mmdX5+hMTVdCavWFBfrWiC4EhTj8Y9pVXe9s5G/5TQ9sQkS
 BIAcVuNYZPt3EdpB13WSA8Nru44ke/NsPMxoFNb/jYVkXvSdL6AlR2Q/Mz0A6k+MBLu28PtNNZ9DS
 EqbS9Y9g==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wRPRU-0000000GV0l-0me5;
 Mon, 25 May 2026 07:09:40 +0000
Date: Mon, 25 May 2026 00:09:40 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Anand Jain <asj@kernel.org>
Message-ID: <ahP1tCc81ascjwxJ@infradead.org>
References: <cover.1779367627.git.asj@kernel.org>
 <1c60be06ce79778404079c8b1c1d2e09f64cb38e.1779367627.git.asj@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1c60be06ce79778404079c8b1c1d2e09f64cb38e.1779367627.git.asj@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1wRPRe-0008B6-7L
Subject: Re: [f2fs-dev] [PATCH v5 03/10] fstests: add test for inotify
 isolation on cloned devices
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
Cc: hch@infradead.org, zlang@redhat.com, amir73il@gmail.com,
 fstests@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

> diff --git a/common/config b/common/config
> index 4fd4c2c8af11..605a57947a40 100644
> --- a/common/config
> +++ b/common/config
> @@ -242,6 +242,7 @@ export BTRFS_MAP_LOGICAL_PROG=$(type -P btrfs-map-logical)
>  export PARTED_PROG="$(type -P parted)"
>  export XFS_PROPERTY_PROG="$(type -P xfs_property)"
>  export FSCRYPTCTL_PROG="$(type -P fscryptctl)"
> +export INOTIFYWAIT_PROG="$(type -P inotifywait)"

Usually we try to split infrastructure changes like this out into
separate patches.

Also any reason to rely on the obsolete inotify instead of fsnotify?



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
