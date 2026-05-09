Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACACFCD3447
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  9 May 2026 08:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BF5T17clISlA/6nlixi3apRxM+uEyWY1O3+xBZxfMZ8=; b=QxAe6E0EevPuy3+g4tbIitKIwU
	vR1B5ZjNvlKbKO6MalLhpa3cSO82TOtUwVU8RnQtLT7IjkYUwWa1X6+eAqO+BGxH1qJJUhmQmhtV/
	G/7cnTHs+9Om+8LTRsIW288Z604Zsu/EAz+/rrWWUx5VwtZbCKpClVu/JWhKw3xVjR/I=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wLd6s-0000wF-V6;
	Sat, 09 May 2026 08:32:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wLd6r-0000vy-5t
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 09 May 2026 08:32:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0gaF6v7clslIeTm7mUuehGxXqyLyYdTta6zh2zZYLfM=; b=EYoWvg0gXsFY9dTL4dBFG9s2Q7
 nMO7t5aN3Pu+im/XbuFV3jpBHevkYibmRfcs9w141cU+okNda9+6TQ2UTSPyjHxwKKD6RXW+e7RGB
 QsRTUtwufKL7EePVTZfxuMqLth5NDTfrNWhFw07RN4BrehSLnAYKu7wgQj8gi3FsPMzY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0gaF6v7clslIeTm7mUuehGxXqyLyYdTta6zh2zZYLfM=; b=SGM9tzGNRZgE6dWYRVHuPzDTU7
 Axm2VTZN/86nnudWzcfhQnHeNgiHJeB0klC8C8VfYuGw0no0l4rMDNqL12cgK9gkKugizs/JkTLuP
 iisqgMIF/GDGe6Cm9GyjHtLuPJK1DpbOyb73VmBV/WtbTQryo9poTPf6VzvyYdU+7wK0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wLd6q-0005GT-IB for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 09 May 2026 08:32:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 4984743C96
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat,  9 May 2026 08:32:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D68FC2BCB4;
 Sat,  9 May 2026 08:32:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778315543;
 bh=rBa1BN4GxZMQIzRfiSYSjlv2BAXjbrz1T+w0QAHMa7g=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=GXhWytKo+hH6XDoayHPYUrrvvmrarGmjL47Ryg9lTgrzLrdqWmMSK1eRI2BukRja6
 8t+HgjoW5c37DmEkz5zL4+xb8SAGsvkklYRlU5u+lhNsr4qs9p5Z+R6V/UXQFMAu6S
 bWGu2Q8jGSNFwZqi2RHs9i432ytic6ohIwHUnnlnKNcuA0E1pkT9peOpjRYNLHlKWH
 GU6oQtyCBqArKrV6VTSsQyHe3lmDCJyhHrWpgx8+2Y8+NplqOgGGzbCZXGn5EIJdv8
 R6OPyH9vN2dNhXbVbTK3LWHErGNAKjc+2WZ27O17rqWPNJzd7u1HiP6oVgC6Dz3EYL
 yuwYxipohhdog==
Message-ID: <66f37d4a-0276-4217-a363-8259fa8190aa@kernel.org>
Date: Sat, 9 May 2026 16:32:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
References: <20260409134630.3693274-1-jaegeuk@kernel.org>
 <20260409134630.3693274-2-jaegeuk@kernel.org> <af41ldQi2PoFFaTH@google.com>
Content-Language: en-US
In-Reply-To: <af41ldQi2PoFFaTH@google.com>
X-Headers-End: 1wLd6q-0005GT-IB
Subject: Re: [f2fs-dev] [PATCH 2/2 v2] f2fs_io: use O_RDONLY for fadvise
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/9/26 03:12, Jaegeuk Kim via Linux-f2fs-devel wrote:
> We don't need O_RDWR for fadvise.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
