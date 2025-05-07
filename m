Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE31CC3ABBF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  7 May 2025 14:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=be2dqriBuxPBXcHdBtzkcsqBP/Z73ohzI4RUDJmcKuk=; b=KSNS36V4Labuwl4TC5eOmCpYA+
	PdNzPVbAs3hPZpDo4UcLkUnoeYdEMhDWcc8XFKvkUHq9sGGLOVD5zWtD1s9JD+JxuUYX+60xylxQA
	vFeJiu2iuRBriBGg+JYCxEcotNhPdaAyuMWp9ZMgISCXU/+4w7QRq4aQH7mHq07bJEpk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uCg31-0007Gg-Kw;
	Wed, 07 May 2025 14:46:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1uCg2v-0007GS-20
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 May 2025 14:46:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Eqo+FfgxtkYw+tD555xGvoWqY2CRE2mRxTIEsSVdXEs=; b=Pbf719n883/cBVXhGwNb0n0b50
 7+NdVa6DRHDkqGmwePPwVzIS9Fc6XxaVpkH6XXGTgm7hcDf52yUu6gBFHKfBNg12f7FFLQy+WEP8E
 ooUGoDVJFqaCqBv5Wmy8GPtQQQLcmo1SR25h14unS9zOyD9XKV1pqsSHKczAWb0ionSY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Eqo+FfgxtkYw+tD555xGvoWqY2CRE2mRxTIEsSVdXEs=; b=gFDi1RgcwgFyC61uSiRcmhfQnf
 zGE6H7ln5lnL5mMgaKoBwoIyrHZvjNfObQF9EYuNxoOoho5rHm8dEqQ2L1i6cmQPWy0khYnythygv
 4uN9el2kfnSQzByYnkn1MSogdYtzpwzD0Q/MT0mpG1gXhjyJRaSEHa/ZKkj+fqdHAy5E=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uCg2e-0003Um-Et for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 07 May 2025 14:46:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E8E2F4A2EB;
 Wed,  7 May 2025 14:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 788D8C4CEE2;
 Wed,  7 May 2025 14:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746629190;
 bh=TSBK7Zhp0qoNQXQ37DDp2OqwBn69raU+RQxf+KNX3Lc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=lzomURi86Vj2XKf9yhX3YM9dt2TD0Aa7KqeMMIwv/ThfRWONpC4R93DzKY3M+qvgD
 TWFNVWpVKeZF2s7u/f33KBWM9EQR9GOHcpqMYtlzu8GbB81NigJU6eqxrKTH9ZN6z+
 Bve/ICkghr1CEtylZv3J8ypU6l9vG1hBbplBmcnMWdTUBDGrVPeBzAB7Ei0c17JhDc
 2BZcaqP2G3UlSglmy0Fhvgi9yBSv03l/TH4I/DbGNT7tiXc4xLarH6uMDNl//vVccW
 1aXpmoEid/a/1NjWmPFMgin1UD+Q0rBJpIQKXeLPibKLjr+KaQtiTlweFJvw8frRjA
 9w+m+YWXDpFKw==
Date: Wed, 7 May 2025 14:46:28 +0000
To: Eric Sandeen <sandeen@redhat.com>
Message-ID: <aBtyRFIrDU3IfQhV@google.com>
References: <20250423170926.76007-1-sandeen@redhat.com>
 <aBqq1fQd1YcMAJL6@google.com>
 <f9170e82-a795-4d74-89f5-5c7c9d233978@redhat.com>
 <aBq2GrqV9hw5cTyJ@google.com>
 <380f3d52-1e48-4df0-a576-300278d98356@redhat.com>
 <25cb13c8-3123-4ee6-b0bc-b44f3039b6c1@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <25cb13c8-3123-4ee6-b0bc-b44f3039b6c1@redhat.com>
X-Headers-End: 1uCg2e-0003Um-Et
Subject: Re: [f2fs-dev] [PATCH V3 0/7] f2fs: new mount API conversion
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, lihongbo22@huawei.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 05/06, Eric Sandeen wrote:
> On 5/6/25 9:56 PM, Eric Sandeen wrote:
> > On 5/6/25 8:23 PM, Jaegeuk Kim wrote:
> 
> ...
> 
> >> What about:
> >> # mount -o loop,noextent_cache f2fsfile.img mnt
> >>
> >> In this case, 1) ctx_clear_opt(), 2) set_opt() in default_options,
> >> 3) clear_opt since mask is set?
> > 
> > Not sure what I'm missing, it seems to work properly here but I haven't
> > pulled your (slightly) modified patches yet:
> > 
> > # mount -o loop,extent_cache f2fsfile.img mnt
> > # mount | grep -wo extent_cache
> > extent_cache
> > # umount mnt
> > 
> > # mount -o loop,noextent_cache f2fsfile.img mnt
> > # mount | grep -wo noextent_cache
> > noextent_cache
> > #
> > 
> > this looks right?
> > 
> > I'll check your tree tomorrow, though it doesn't sound like you made many
> > changes.
> 
> Hmm, I checked tonight and I see the same (correct?) behavior in your tree.
> 
> >> And, device_aliasing check is still failing, since it does not understand
> >> test_opt(). Probably it's the only case?
> 
> Again, in your tree (I had to use a git version of f2fs-tools to make device
> aliasing work - maybe time for a release?) ;) 
> 
> # mkfs.ext4 /dev/vdc
> # mkfs/mkfs.f2fs -c /dev/vdc@vdc.file /dev/vdb
> # mount -o noextent_cache /dev/vdb mnt
> # dmesg | tail -n 1
> [  581.924604] F2FS-fs (vdb): device aliasing requires extent cache
> # mount -o extent_cache /dev/vdb mnt
> # mount | grep -wo extent_cache
> extent_cache
> # 

I meant:

# mkfs/mkfs.f2fs -c /dev/vdc@vdc.file /dev/vdb
# mount /dev/vdb mnt

It's supposed to be successful, since extent_cache is enabled by default.

> 
> Maybe you can show me exactly what's not working for you?
> 
> -Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
