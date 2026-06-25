Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96D99CDB47F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:01:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:Message-Id:Date:References:In-Reply-To:To:
	MIME-Version:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lF6LhTBn37EwVKkt937tWBln/2oUbfFtCC2cGxHZ+nQ=; b=bTSV+q7SwXXK93vu0OYPSZCpvq
	PJ6lFDt+oDxjaIUg70VxyVVQkSovZje+kZTtnUKV+9HfpSTq3WeTvaTvJPsf7npFVQThgDUZFwXH4
	4NcLfsgRMsyin5IZztJ5FOXh7NNzTIaOcO1qP0TtPCb6cl3fPGjzFmOi78vMVritPCtU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wce60-0006gd-Az;
	Thu, 25 Jun 2026 07:01:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <brauner@kernel.org>) id 1wce5z-0006gW-G0
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 07:01:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-Id:Date:References:In-Reply-To:Cc:To:From:
 Subject:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+vv8SM8eUAW3MCRiYBMwLSNBJkmkWiJDn52oy/sEKaQ=; b=FvcinvP6rrvsfa8bCgPt7xP+/d
 G1bcY/1MMfx8rNHJS32h5sZCLuoBRI8SkCRVS1NlMsQ0ClBqlIyVwARbpkEXQK0QVoBbZOikNv3lm
 Kt3/6TonMzdkgmpPkah6IZcBEOsh2IMdidW+SqVHJWkXSAo0d1SrCgQuLJgPrcKgu4eg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ; h=Message-Id:Date:References:In-Reply-To:Cc:To:From:Subject:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+vv8SM8eUAW3MCRiYBMwLSNBJkmkWiJDn52oy/sEKaQ=; b=TG2/MXWJf64a2NcRHtd7+Mbdtk
 T7wv7n3aIVwcG42SYAewaUojb982XdaqeK/7Rhq733Gm9rklF6OB8aY3Wlf8ji+gHDLroQROkFo78
 MC/BtuDtp4PeGFvmZKAIP2CcbGT8uhr82rM9JU1ddO7y8FeAUVP8dwHstHRLV/21DjM0=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wce5u-0003Hg-TD for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 Jun 2026 07:01:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A90A460217;
 Thu, 25 Jun 2026 07:01:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D3B1F000E9;
 Thu, 25 Jun 2026 07:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782370900;
 bh=+vv8SM8eUAW3MCRiYBMwLSNBJkmkWiJDn52oy/sEKaQ=;
 h=Subject:From:To:Cc:In-Reply-To:References:Date;
 b=dyUeAerzru3xhnFxtZ+CbG65FbUdOu0DgT1EdRs+Fh5nbuoTM0kZGTsrCHmZQSZ4E
 Mf5hx1nT9BoSHOfwF5eNt2DzQ3l9GYvzQ+EKyJCGerpBchHmAvSWAa2xGHkpYwr4b/
 3hGROIWH8dacrQ6f1LjyWDrVJ282Abav4LvIsn2rE0M9dHbgE0+UL+0uZBiX9FwjKB
 oMdDPuJmhgHW6m8NbHBaRyBePCbnPFCqeepO/XS4wAsPQmL0T63OcZE6Q5ZaWn/S+X
 uTBN9FKvdAcDTNbMASr+WpgrqFu6Da33TiS0cOOmJRUc9GfArmLx4HXm/ui2R3RWwp
 yzJYU8tTtQNnA==
MIME-Version: 1.0
To: Eric Biggers <ebiggers@kernel.org>
In-Reply-To: <20260624050334.124606-11-ebiggers@kernel.org>
References: <20260624050334.124606-1-ebiggers@kernel.org>
 <20260624050334.124606-11-ebiggers@kernel.org>
Date: Thu, 25 Jun 2026 09:01:34 +0200
Message-Id: <20260625-kniefall-gemauert-strategisch-f4ad784de60d@brauner>
X-Mailer: b4 0.16-dev-d9d01
X-Developer-Signature: v=1; a=openpgp-sha256; l=381; i=brauner@kernel.org;
 h=from:subject:message-id; bh=o7y3zrWWLolQ8rjHQUEvtkfJrU1SIgeSJi1z7iC+nrk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTZXArIvNXXXfhZxvBow6k26TVNu3SOVMs/nWLSIni5J
 mSRaMXajlIWBjEuBlkxRRaHdpNwueU8FZuNMjVg5rAygQxh4OIUgIn8CGT4ZzTD+2Fi1YtLfesm
 c3BFrgviP92eJvfK9aaOhcbLOkl3Fob/rhOf+5125WLY2tO6Q+q5pbTe9sLkpgtL/h5U6f9/paC
 OBQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Headers-End: 1wce5u-0003Hg-TD
Subject: Re: [f2fs-dev] [PATCH 10/16] fs/buffer: Remove fs-layer decryption
 code
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
From: Christian Brauner via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Christian Brauner <brauner@kernel.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
 Zhang Yi <yi.zhang@huawei.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 Andreas Dilger <adilger.kernel@dilger.ca>,
 Ojaswin Mujoo <ojaswin@linux.ibm.com>, Baokun Li <libaokun@linux.alibaba.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-fsdevel@vger.kernel.org,
 Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026-06-23 22:03 -0700, Eric Biggers wrote:
> Now that fscrypt's file contents en/decryption is always implemented
> using blk-crypto when the filesystem is block-based, the fs-layer
> decryption code in fs/buffer.c is unused code.  Remove it.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---

Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
