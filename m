Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D998DCD4F37
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 May 2026 07:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=VQThkmBihcxMqPCptK04qR/do5/HVd9nlYAULNDVNLk=; b=ck0BEV4ngKbB42L5WDlvDiGQ3E
	8IWlCmGChWHrRZM+oz1L9fxuhQarGLLs5sVkB5gA6Y8PBgu/N6Ei5JsuWKo9x0Ze5wBO4luSCLKD/
	wkp0tYo+xa1qT7h5xEZN6FeC7a1hNnUSkiAkLEvty72g7XTXYG8aKqk7yRpC5+diVuCo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMhMy-0003cx-My;
	Tue, 12 May 2026 07:17:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dlemoal@kernel.org>) id 1wMhMx-0003cg-O9
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 07:17:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tJHclFQXF18N17dMI1WUkkOAH7zQLXcP8+f8FCNiVFI=; b=hLrYALdoBRlfkY90qKPXJk3o6U
 9IQgqR6cMhq2+sNmpC0Vc9L2ExCRMfnS+vw+FKpubyO5lNDQHluGZdrxsDZcqdzDzY2rfYaVEFo0j
 YS0HAhnNsXFx91XydCJ40CNviTm3VyA9NzBMmoGQ+K7K8noQkffgF4JJIPSwAp7Mt3J0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tJHclFQXF18N17dMI1WUkkOAH7zQLXcP8+f8FCNiVFI=; b=JAD+dBg6laCQYvZgOf5g755qiK
 orBwBfed1+T5meFP+6SnTZEvTWgYSzWxMUhwxFE4uo0Bd5oITVK0Mo+w7Y1MCwhL+xkGofwGK5tvk
 rrjC2+woRNpUbjOTJcAKB64JnmLpIJHZKIIWepxRQkNDRJM/RZEG91KXWIO6MXuafRE4=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMhMm-0001RX-QS for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 07:17:21 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 0860542B1E;
 Tue, 12 May 2026 07:17:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FB1EC2BCB0;
 Tue, 12 May 2026 07:17:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778570230;
 bh=98mFo7pkXXhyp9+X2ioMv1DmZPs1w2tyrej7VobxKEk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=iIrRBVhMsfcFd8c2S3m3a8T0kcFhIOtgvw+B1wc4Z+F9AGHqa2Q4wJLfDihSwuvKA
 9EHcoUhMUamvE0OG5XYIdztmYfey90VXjjTFqwg3o2L6rXQ9SkypKXMe5MeYQjKCPU
 tsvV+fBHpWRp4j166nAtQPNhdKJVpvb+lAwRMS+df1+5x7pjtjuYvfzhnW29hq2GtH
 8o1S+/mUmIon2yUaU3SJRUwZKHtx6T6N+tJJ2t2uoihJJtq2Ym+RSFldlpzI/doRk8
 3JxjxZkF5Srvye0Gf8WDLX0nDvfUzScbFHdd73uZu3gax6MKiiqMjCYtozBL3MMONV
 pmRlkBWUhk5hA==
Message-ID: <44a01a39-c902-4c54-a7a6-07bc1f4d5f06@kernel.org>
Date: Tue, 12 May 2026 16:17:04 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christoph Hellwig <hch@lst.de>, Andrew Morton
 <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-5-hch@lst.de>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260512053625.2950900-5-hch@lst.de>
X-Headers-End: 1wMhMm-0001RX-QS
Subject: Re: [f2fs-dev] [PATCH 04/12] swap: restrict to regular files or
 block devices
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
From: Damien Le Moal via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Damien Le Moal <dlemoal@kernel.org>
Cc: Paulo Alcantara <pc@manguebit.org>, linux-doc@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Hyunchul Lee <hyc.lee@gmail.com>, linux-mm@kvack.org,
 Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-block@vger.kernel.org, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/12/26 14:35, Christoph Hellwig wrote:
> Various swap code assumes it runs either on a block device or on a
> regular file.  Make this restriction explicit using checks right
> after opening the file.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
