Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B687FCD4855
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 May 2026 07:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X8Jy053eYi9uoJxUvLk6y+gWpOpBJeaeAdUdEHOn1ZE=; b=SqY1LemNgX2lG5rw7GCQA3u9+R
	cF1TjKEPPSZ+TocaiCV2IZdFsuDA9du13ILTiafhcLDbj63BphvFl5GGA9wrxMOCNaBswQkvRS3K4
	YX4uX1VFhuYhyKYqXgidyJ9TTsLTm4XZeVfZRp3AZ4/BRQPlXeXrYpk7Bv+Ggy3MJAUE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMhfU-0007IZ-4D;
	Tue, 12 May 2026 07:36:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dlemoal@kernel.org>) id 1wMhfD-0007IF-C2
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 07:36:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8PO4GLuGZmYeFCQwMZxbvC9v4c7bCR31DC49QgbGVV8=; b=XMM5e1dWfD5XfQ7PQKGJ9ZKvFb
 OUenVw1cf+k8I9bUFe0c+Dt7JtvC17kZqKdX9itYY/Vdz5kuOqkxQWCth/W5gKAXAFB7viHxUh8Hy
 8y36tlFP6N1WyYo6QzRyxknBaB+idKuNaZc6mi2boOwRnMgAjcGgWCAaf2c9MmRN0iZE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8PO4GLuGZmYeFCQwMZxbvC9v4c7bCR31DC49QgbGVV8=; b=VZi/hcSwg3JAYyoz8uHUEcYSd1
 FvAagdiW1vU8Takz3YpjVP47SdzAMNKAw4RDjYUQiLqFK1nHhzkvf6XfK3VgEI/fC1D09doI/Obk+
 CIiTqTfonBczy+v4Wi5BDG8mfIcLqB5ZNyx3mfM8hPPQtDOa/llm+PY8ZOq12Q+mcbdU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMhf7-0002gK-QD for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 07:36:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 97E5E6001A;
 Tue, 12 May 2026 07:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB31C2BCB0;
 Tue, 12 May 2026 07:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778571372;
 bh=xfvW1wpEEpdnJkpRrdMoCWaP4d2q5LDk8OL7iCWt7D8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DwiA25kbq/Td3a9MvR3WH58od1Vae6OW7xTi9Au6t+Zxak+ySYwcyXatBRk/nSr+C
 XiF1aj5t8J/zauFcxSSUJ4UMlZliBxyUBhEOn4t4A0EasYiB9DFsanXEeNirLMMncf
 /tYXyyBXROFd6YoiJbNa/pMDtPmAKbffUNntnCRP6f59o/WOMTGj5H/hCXhkFoD2s2
 Gw32M5q4A/mv9h6b32INXyOm2qVf1in/c/G3Mjf1sRDBup+Qe7hjxeBcAsBOS1xK9T
 QuVhHaZJQauyufFxTordqNNUGfqZO/Is1q930JMRcuGAk8Ge+3gpSB7gtvX7VpFoci
 iJpVyB+/LUR3Q==
Message-ID: <5eb5cfd6-5062-40b7-ac4f-ef8f13e0a145@kernel.org>
Date: Tue, 12 May 2026 16:36:06 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christoph Hellwig <hch@lst.de>, Andrew Morton
 <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-11-hch@lst.de>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260512053625.2950900-11-hch@lst.de>
X-Headers-End: 1wMhf7-0002gK-QD
Subject: Re: [f2fs-dev] [PATCH 10/12] swap: add a swap_activate_fs_ops helper
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
> Add a helper abstracting away the low-level details of enabling
> fs_ops-based swapping.  This prepares for taking swap_info_struct
> private.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
