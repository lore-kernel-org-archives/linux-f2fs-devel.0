Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F820CAC592
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Sep 2025 14:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DwYiP+tbXiOgjMYOCAY+tM/cDO3JLSPpSscUaqztTBE=; b=bxsUTPdRpE71rZ/EBWljsLeRqq
	Lra84QN0NZvFHio4Nm4R43WlY7fT8R7dmJCSYVXb+/jLbFYUqyZmT2eqApR2ohtPUo/36mYwg0w4e
	SZtYeQbKDM5JCD8zaEeDdiiNbYJCdX3cbQXsdrI/o1BTOnCRswyGq+NQt/K6qM8uK/QE=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uyANF-0003r0-8s;
	Mon, 15 Sep 2025 14:40:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1uyAND-0003qs-Ao
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Sep 2025 14:40:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=n1Y1lE1qPsL53ioIEtigZX3yA3D/KLLm4nAqwS59w1s=; b=boCqJudHJVN76bFbgZm22kzpQK
 sER37hb/xIjnRQwRkTIG5kLMVyGi6aRgJm47bzhAWkw3R+12GBKdpaFbR6lZpBOxyc3DceoT/3YxH
 hb291BVC1bW2e5t4mEq5Khx9/ABKeuMr3HoiYvR5JHVduQ12KZK6a6ITFvS95V3xKnps=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=n1Y1lE1qPsL53ioIEtigZX3yA3D/KLLm4nAqwS59w1s=; b=bbGln/yJXCWROP5BUHRcnEXlHl
 mnT/rMf8zpqMvDqdxpb1dER/e0a/lfGJznedhXxjdTFSe78xNKvfgXCtS2L0vtrlID1ZuCp/XkXfg
 Z3iAMz/JV71orgwYTjK/NJi7Ntz61zSgHeHmbArOB00blq2cCCjUzjpKYrhMrzFXvIk0=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uyANC-0006NE-SN for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Sep 2025 14:40:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6A87340BA1;
 Mon, 15 Sep 2025 14:40:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F24C4CEF1;
 Mon, 15 Sep 2025 14:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1757947201;
 bh=EO0NYEiZDq71xTAUjldgSm08C6CtejksZMgKKNt5NI8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=NSgzu1v5NJPKv/Vz+5FAYMrOyn8EPWSERJhTOEr1diQwb+OqNTq7XyT/B/7LH278H
 oWWrf7+/RAStv7aKVmSKiOB0s85JXMg/JOdWnzZ2DEvFvRhfM9V7DYk5YWIPrtXY5+
 DOdrDRpEpmLCCDaHIakB/n+LdaqemDJLTuIcEwWtYpH54WKK2tU3nX6dA8VlGcQZZO
 8JYGdL3e7kG/Pv5wzshb9L7ayDUsxpZ2QfCnjgh0QTM8lZS7GdHyaeqoLWt0DTNQNn
 jdcnkRxOkLqUHmJELW5LDL9iTPKM9rPV3CGsMI5w3tmTz2wj4nxoAaagPcBLlXLXQ9
 mZo4Z8Zl7gSUw==
Date: Mon, 15 Sep 2025 09:39:51 -0500
To: Jan Prusakowski <jprusakowski@google.com>
Message-ID: <20250915143951.GB1993@quark>
References: <20250915100451.810719-1-jprusakowski@google.com>
 <20250915100451.810719-2-jprusakowski@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250915100451.810719-2-jprusakowski@google.com>
X-Headers-End: 1uyANC-0006NE-SN
Subject: Re: [f2fs-dev] [PATCH v2 1/1] common/encrypt: Do not run
 _verify_ciphertext_for_encryption_policy on compressed FS
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
Cc: jaegeuk@kernel.org, Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Sep 15, 2025 at 12:04:51PM +0200, Jan Prusakowski wrote:
> common/encrypt: Do not run _verify_ciphertext_for_encryption_policy on compressed FS

A better title would be something like
"common/encrypt: Explicitly set the test file to uncompressed".
(We do still run _verify_ciphertext_for_encryption_policy.  And as I
mentioned before, there's not really any such thing as a compressed FS.)

> verify_ciphertext_for_encryption_policy() checks if encryption works
> correctly by reading encrypted file's contents directly from a block device and
> comparing it to a known good ciphertext.
> 
> This, however, won't work if the test file is also compressed. So this patch
> adds a check if a test file is compressed and disables compression in this case.
> 
> Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
> ---
>  common/encrypt | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/common/encrypt b/common/encrypt
> index d4f6e3dc..c25ff5a4 100644
> --- a/common/encrypt
> +++ b/common/encrypt
> @@ -790,6 +790,13 @@ _do_verify_ciphertext_for_encryption_policy()
>  	_set_encpolicy $dir $keyspec $set_encpolicy_args -f $policy_flags
>  	for src in $tmp.testfile_*; do
>  		dst=$dir/${src##*.}
> +		# To make sure the test file is not compressed we create an empty one
> +		# and disable compression first (F2FS won't allow resetting the
> +		# compression flag if the file has data already in it).
> +		touch $dst
> +		if lsattr $dst | grep -qE ".+c.+ $dst" ; then
> +			chattr -c $dst
> +		fi
>  		cp $src $dst
>  		inode=$(stat -c %i $dst)
>  		blocklist=$(_get_ciphertext_block_list $dst)

Is adding 'm' (FS_NOCOMP_FL) needed too?  If not, why does it exist?

Also, have you verified that the tests that use this function still pass
on both ext4 and f2fs?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
