Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43857CDE008
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 26 Jun 2026 05:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jXgUmn2q/lKY6D0MZ3JmHp76PCOp5t8U3O75ZQ0Jz/o=; b=i6SGyUKq86aFaVlvBLHVMhIrBG
	PArPLAn09EcsChNqpmEY3uknUVyfZyZs2fytEuLyUaz6MowyQLdCDLOnd3DvT8g+Vw/EksstUIkI4
	OmPAmvp3rg/19DCW9c76iQYNuMcz3zkR819qMEeijWeBNCzrwOoyksG1ll0VXrjfsNHs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wczCE-00056A-Ay;
	Fri, 26 Jun 2026 05:33:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1wczBv-00055k-9e
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 05:33:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Mp3SlZ1WqzRowAF3YrcgCCdPQ9/dBMqCt5uytoZWLmU=; b=miINZwda/6yCS6bmm0iT/XDNlN
 e+qrmmS9Br3V7NERarJj+UgcLqnvGUukt+UrGz7pY291JmaGDsg2cmDexDhOj3pY1bXppBouy5mdO
 xkbXEYDA2bL7FGbirkKHlEcRtcmxaaFwHkhCOzAj3/J12aLfnN8VLQMY75DkefAvFbv0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Mp3SlZ1WqzRowAF3YrcgCCdPQ9/dBMqCt5uytoZWLmU=; b=l+GYCOC9GgXa2JGsDsc8PIYqPb
 oz5Yv3SkqhGkAa8gzKpircdf4Z4gsrnQCmpTltIRWh1YAz5pKI/C5+BHs3TI+PViisLH+t79EgvOR
 R8QwBQbMg61QTeRDBUFzsibqSgbqSJ3hzqaiC2sA8H1HONIB6Pf8V5nARdbkIkA/OLug=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wczBn-0001II-Op for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 Jun 2026 05:33:21 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id ED7B468B05; Fri, 26 Jun 2026 07:33:07 +0200 (CEST)
Date: Fri, 26 Jun 2026 07:33:07 +0200
From: Christoph Hellwig <hch@lst.de>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20260626053307.GO9043@lst.de>
References: <20260624050334.124606-1-ebiggers@kernel.org>
 <20260624050334.124606-17-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260624050334.124606-17-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1wczBn-0001II-Op
Subject: Re: [f2fs-dev] [PATCH 16/16] fscrypt: Add safety checks to
 non-block-based en/decryption
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
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
 Zhang Yi <yi.zhang@huawei.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Ojaswin Mujoo <ojaswin@linux.ibm.com>, Baokun Li <libaokun@linux.alibaba.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-fsdevel@vger.kernel.org,
 Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jun 23, 2026 at 10:03:34PM -0700, Eric Biggers wrote:
> fscrypt_encrypt_pagecache_blocks(), fscrypt_encrypt_block_inplace(),
> fscrypt_decrypt_block_inplace() would dereference a NULL
> fscrypt_inode_info pointer if they were to be called on a file that
> hasn't been opened yet or on a block-based filesystem.  Since they have
> the ability to report errors anyway, add WARN_ON_ONCE checks for this.


Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
