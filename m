Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B462C76188
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Apr 2023 22:17:04 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pjoxc-0005x7-58;
	Tue, 04 Apr 2023 22:17:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1pjoxb-0005x1-34
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Apr 2023 22:17:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=aTD6KCg9cShNTj6SRxO/F3XZ8OeDIzdqsH4W/H4fF2w=; b=QpTW6vqsKcJUCtFSbK+5ET87R7
 +U7neGto7nX9SsTRi2FRqG6FtHPq6G3JotcfOXWYksdSNfuAwvHZHw2hXQJfCnDiyatHfld30j5Jx
 pN8QUi1Cd9Fvas+VaEgubEQFS9BVDW/ESm8/sLIJD+hnQkTTUvlAy7Ws8+k+qeRrwLEA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=aTD6KCg9cShNTj6SRxO/F3XZ8OeDIzdqsH4W/H4fF2w=; b=WkM+07f94pJDX50+BLOKToTKbT
 Woit3x8BUiSmA0Wrftvawq1awdwLoi3a81z9bxvzPTJm7vUc5ZfWhH9lOxtJiIugzkPhf9wmH/cVu
 G6jSf3da1CruDh5gtimhF6ytefxXhOPoTlCFhhHYFC4UC6jDSOjzGngAw1EM8AvtRd/M=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pjoxZ-00FOx0-MC for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Apr 2023 22:17:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4CF4763966;
 Tue,  4 Apr 2023 22:16:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3400BC433EF;
 Tue,  4 Apr 2023 22:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680646615;
 bh=iq/IdV4ogpOzaM8KgGTnYC5Td3WCpb/PqmrSUjFcqq0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hKIBSlBctkP5bivjN4Y21mckkcqW66+dkJqVt3sV5xlPSN1yzxtbcIDAa/udoQiUM
 sYGbOLNwfOA0gXRR+Wndw2VsarlhINwbmR9rKVH1FeHvdejvWrBskWjfnQnco9YqvD
 rpI3rk+9EzaMTkMEFIRuzDVL9UMVtvyfJBQ1f5Ze4NeqUuke7n1BCeowZBAWgMngKo
 42ZuMczWbvBA3Owwg/N+nslkw274BP30Pj/y3YKUBj/353slDtMf8ZPciuUUqEM6Ip
 0wa3X6hCp3Y9aaK3d1yKPuqKpW2wz0WLI7SD2d8mkTPKHHanh741qLv7i4NdaAMa8g
 +Pz1NY60vkAcQ==
Date: Tue, 4 Apr 2023 15:16:53 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Zorro Lang <zlang@kernel.org>
Message-ID: <20230404221653.GC1893@sol.localdomain>
References: <20230404171411.699655-1-zlang@kernel.org>
 <20230404171411.699655-4-zlang@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230404171411.699655-4-zlang@kernel.org>
X-Headers-End: 1pjoxZ-00FOx0-MC
Subject: Re: [f2fs-dev] [PATCH 3/5] fstests/MAINTAINERS: add supported
 mailing list
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
Cc: linux-cifs@vger.kernel.org, brauner@kernel.org, linux-ext4@vger.kernel.org,
 djwong@kernel.org, amir73il@gmail.com, linux-nfs@vger.kernel.org,
 fstests@vger.kernel.org, linux-unionfs@vger.kernel.org,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, anand.jain@oracle.com, jack@suse.com,
 fdmanana@suse.com, ceph-devel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, ocfs2-devel@oss.oracle.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Zorro,

On Wed, Apr 05, 2023 at 01:14:09AM +0800, Zorro Lang wrote:
> +FSVERITY
> +L:	fsverity@lists.linux.dev
> +S:	Supported
> +F:	common/verity
> +
> +FSCRYPT
> +L:      linux-fscrypt@vger.kernel.org
> +S:	Supported
> +F:	common/encrypt

Most of the encrypt and verity tests are in tests/generic/ and are in the
'encrypt' or 'verity' test groups.

These file patterns only pick up the common files, not the actual tests.

Have you considered adding a way to specify maintainers for a test group?
Something like:

    G:      encrypt

and

    G:      verity

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
