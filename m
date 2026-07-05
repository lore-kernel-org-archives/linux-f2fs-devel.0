Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B12DFC43458
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  5 Jul 2026 20:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pdS9in6WaEM+oSScX9RIfRh+z9+sBODuTgMCuyhUVPk=; b=P/jR73Wjn+nwRry6oa1HhwEPfc
	4bt1rhL6j3Er/PBNgkLtFOVsgLbBdFCfzntkkdoYvGdMrRtyiaZlPAuhpP0sgyqJJWBLnM2YNt99C
	m+i+9+2L3gGscJ+Qg+YnAr+rN5NfPw3Go9ptY0sOHqMH3X5snSZQyc0tK5e8fABEdN9Q=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wgTR9-00074O-Ou;
	Sun, 05 Jul 2026 20:27:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wgTR9-00074H-3G
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 05 Jul 2026 20:27:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aJn2MZML+MCpXCm1e6eEUa6PDLxWsVXQhSkdQWF+JNA=; b=BgZJ/dB4n7cgEK4DoJoHsl+QIA
 8Lp64dllHLLVcpT5SbH/kjdb212nKRF9RRg244dqE04AldeH7lwzZm6YI4uzw/y8JnjZptW2URjh4
 ljDEMAGyHvEB0sg5/mns+Tik18lPT4dsZwOd890nrylI5D195lM1JfbOiGbAW67GeKnI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aJn2MZML+MCpXCm1e6eEUa6PDLxWsVXQhSkdQWF+JNA=; b=JR6uK1hjxVmU13U9SP92e/2e9K
 AkEK1MaZ02apH07gE1T0YAYb/OXep03MV2dp0se1RIdwg8OOTAEpbxvDzn2Oe/odwi3GI049ZXFXc
 QlxgDWgGb3hscFqNQtTq2tjRu6/fBebJlA6RA/XtyiWNNsENnYyMPBeWfXjGumYpgeF4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wgTR8-0000rB-U9 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 05 Jul 2026 20:27:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C2F3B60018;
 Sun,  5 Jul 2026 20:27:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBB921F000E9;
 Sun,  5 Jul 2026 20:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783283249;
 bh=aJn2MZML+MCpXCm1e6eEUa6PDLxWsVXQhSkdQWF+JNA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ONkvNfO7vIPU2gSxzCAj2/U9qxr7COrOU3XVQNuoO3cyO4Gb2EB2KBrhR/KthBiDL
 lIxVNbcyenO7dxge1RD+HatAJg84Rq3H+it1iXBGk1WTDVNIXVr3CC+TIhHlmrrHrV
 mnP89jhTtAH09EIjmBbOUynb+MhUtYRbyVhkrrOzOHX/zNC8VeVVjPjDF7SdCcu17/
 rAowTxvRBxDL9piPQHKRlG9+iuM2LAtakBYEiQ7CdfzyZLLC4hHX3U0hSLAK4GiEow
 MEBZ7LheP/9kIL0fq3lroWPvTxZDICd0FUWpupJsIMcgBEu3U54C3066mKVgf97Q6O
 P3I8XwjHeCHkg==
Date: Sun, 5 Jul 2026 13:27:27 -0700
To: linux-fscrypt@vger.kernel.org
Message-ID: <20260705202727.GJ41916@quark>
References: <20260705194555.75030-1-ebiggers@kernel.org>
 <20260705194555.75030-9-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260705194555.75030-9-ebiggers@kernel.org>
X-Headers-End: 1wgTR8-0000rB-U9
Subject: Re: [f2fs-dev] [PATCH v2 08/17] ext4: Make ext4_bio_write_folio()
 return void
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
 Zhang Yi <yi.zhang@huawei.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, Andreas Dilger <adilger.kernel@dilger.ca>,
 Ojaswin Mujoo <ojaswin@linux.ibm.com>, Baokun Li <libaokun@linux.alibaba.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-fsdevel@vger.kernel.org,
 Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sun, Jul 05, 2026 at 12:45:45PM -0700, Eric Biggers wrote:
> @@ -2724,9 +2711,7 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
>  			 * through a pin.
>  			 */
>  			if (!mpd->can_map) {
> -				err = mpage_submit_folio(mpd, folio);
> -				if (err < 0)
> -					goto out;
> +				mpage_submit_folio(mpd, folio);
>  				/* Pending dirtying of journalled data? */
>  				if (folio_test_checked(folio)) {
>  					err = mpage_journal_page_buffers(handle,

Sashiko found a subtle bug here, where removing this assignment to 'err'
can leak a positive 'err' value of 1 from ext4_journal_ensure_credits()
into the caller of mpage_prepare_extent_to_map() in certain cases.

I'll fix that by leaving an assignment of 0 to 'err' here.

Really, positive values shouldn't be stored in a variable named 'err' in
the first place though.

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
