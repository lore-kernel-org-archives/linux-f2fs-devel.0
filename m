Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C724AC43458
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  5 Jul 2026 20:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5PXSDzWEi379cfx2HjMYoktnqopj/ClJtaMlU7mdAaw=; b=S3JqTYCt0DhwMJdxvSEcLx9K26
	sfrCzxnYvHvYMQw5P1EGbqq03zqb+SjW/7XeLI1V5Ffh3nzQYa2HyOkb1KQQvm1z2sxzCv0FePNDH
	rKsn1B+riiFSR8adHnRlUAQlMsMUeKpKyK07E8Jd1gRUkAjWgDnnQMlNOja7/9untqYo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wgTJd-0006iz-BE;
	Sun, 05 Jul 2026 20:19:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wgTJc-0006it-Ki
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 05 Jul 2026 20:19:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ut7iHQF/AbxXgauDKV+8ArFS+YsvVMBn1LLgz1WNd1w=; b=jYjGzMuEfAKHYBmS6H8teKszAu
 PmO8HB/LcEUSkUG931gqFm6WSQs94iS0pEhyGFzd9nC6Thhm8RVg1tFDmHf/n0tQ666xEqFMU1eOw
 fw5895UmJtMzLWPEUrU+2K65/+/3IPG+Ej0owjz5Lv12UyzUaiP2dHBeNF7UIR4nTKXo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ut7iHQF/AbxXgauDKV+8ArFS+YsvVMBn1LLgz1WNd1w=; b=HPv8+i+LsOsv5R0nui/jJ1/ctb
 2gXZB+999ZHrEjWbJTc31pVsgNZyFU09/zVCz3xtl4GdLG8Yniqp5BJy/4WlPElya6Qq2JIWnzcjW
 UjTwDQOG37AiISe1gfddY/WAl32kflacLrGaDtmXj02RzL+Waium+c/ghRCO6fnrSb5U=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wgTJZ-0007Os-1i for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 05 Jul 2026 20:19:46 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DF5CE60018;
 Sun,  5 Jul 2026 20:19:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19B011F000E9;
 Sun,  5 Jul 2026 20:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783282779;
 bh=ut7iHQF/AbxXgauDKV+8ArFS+YsvVMBn1LLgz1WNd1w=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=ZIga6IiUpJDUov9sJrPSs0xrW+7w/Lo594hWKveoTRiueAcCmhDHGWuoNhKW9m4s7
 KEgUnSAZ12+Ucc+thyl9NcQvL08y8NNwmOh7id67QWB8dePRqmD7kN7kcwq+niA2vn
 dPYO6X+jHzrdGsiugS9gXZ4RHea27n/AGJxRUdsmKgKF6CcgiGb4/m3+N7/Bk8CcDG
 F7yt2a/iTpdVSBl099lqGKINf5Iqg7enT+AZGz9UR3Du9wPVx+6MWV26Du56BgqXxB
 GuY4szfcpBZ3nW8mM9G9a5Q7V7CeHJEypgl31f5Gvdypblqk+0aANDO6HwishVmZFJ
 T9RwWKuveNRWA==
Date: Sun, 5 Jul 2026 13:19:37 -0700
To: linux-fscrypt@vger.kernel.org
Message-ID: <20260705201937.GI41916@quark>
References: <20260705194555.75030-1-ebiggers@kernel.org>
 <20260705194555.75030-14-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260705194555.75030-14-ebiggers@kernel.org>
X-Headers-End: 1wgTJZ-0007Os-1i
Subject: Re: [f2fs-dev] [PATCH v2 13/17] fscrypt: Remove
 fscrypt_dio_supported()
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

On Sun, Jul 05, 2026 at 12:45:50PM -0700, Eric Biggers wrote:
> On block-based filesystems, fscrypt file contents encryption is now
> always implemented using blk-crypto.  This implementation supports
> direct I/O.
> 
> Therefore, fscrypt_dio_supported() now always returns true, except in
> the edge case where statx(STATX_DIOALIGN) is called on an encrypted
> regular file that hasn't had its key set up.  But that was really a
> workaround rather than the desired behavior, so we can disregard it.
> 
> Thus, fscrypt_dio_supported() is no longer needed.  Remove it.
> 
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>

Sashiko pointed out that the following comment in ext4_getattr() (and
also in f2fs_getattr()) becomes outdated and should be updated too:

/*
 * Return the DIO alignment restrictions if requested.  We only return   
 * this information when requested, since on encrypted files it might    
 * take a fair bit of work to get if the file wasn't opened recently.    
 */

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
