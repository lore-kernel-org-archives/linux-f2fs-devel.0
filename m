Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 115A0C6FD1F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  3 Apr 2024 03:43:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rrrXO-0005Dv-Oo;
	Wed, 03 Apr 2024 03:43:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1rrrXM-0005Dl-UM
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 03 Apr 2024 03:43:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vOUsZsN2iNQo+K5f8b8RDtEE7SaVy2QQaMGKZQqum3k=; b=bhnJlG+Elp/A8v9qnCv53Xpst6
 c2PRA9nipQLMOgoeZe9nb50C8kqqkKoT5VTQTG/Dd00fPxu9mZi74L95A7dhh46W7O61+sNnO4HF5
 V+ERg23OYE95+pxFTK0tpzywvdBnemajuIGVR92A5VyGAuelKmwBSUoVx4r2h6z97smU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vOUsZsN2iNQo+K5f8b8RDtEE7SaVy2QQaMGKZQqum3k=; b=md0yaLfQtsf/XOwCJirhhj4LDQ
 xuKRShWuZ+bftW3nuBDDdTcr+nIrEkuAuEdkne9KXdjwF4o6K3NVulk6vUuH7C53SHr2EYBrkFLPg
 HvYvZ+Hh5W5twEl7GYLFxJlBlyTHpgYoSRqmwjZ7aT9eaHJEQPSV3mXt0lLef9FvhErw=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rrrXK-0006Kj-Qs for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 03 Apr 2024 03:43:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 58E93CE1F6C;
 Wed,  3 Apr 2024 03:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18160C433C7;
 Wed,  3 Apr 2024 03:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1712115810;
 bh=s7/TSFoZCTujo5clr5oMUi2k1rXwU6wxmLVEFWWgRkU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=jD8RoC2uZ8BxQS36zgcM+wnGfDSCz+IKoBlYePPxOpmJryZaes5zDeCrR8XuwJo/B
 25sX34qXV3vezh48cN8ekUsylZNy64OPcySwmhAkpgHO5UKfBygdNACIisiWY1OS5+
 +9Bx/+pbzINpirerZ0r+gT9v43p1QKpvyTNuvZb1dV5xS0ycAGbqhjSZ01XsvmuUuN
 WvmDmekhQwtePz21O+1I6WGLUAJM55WxvdNOFjAXDf9hSNnmUpt0ZiZlqxFE0XFtcZ
 Y8UH1+q2ZHxaSXArEUOPgZF16XUqJc/PQnH50BcDWcj7v8DxQl9JvWAz58mrIACq1j
 tXJ9UEz9f+VaA==
Date: Tue, 2 Apr 2024 20:43:28 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Eugen Hristev <eugen.hristev@collabora.com>
Message-ID: <20240403034328.GF2576@sol.localdomain>
References: <20240402154842.508032-1-eugen.hristev@collabora.com>
 <20240402154842.508032-5-eugen.hristev@collabora.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240402154842.508032-5-eugen.hristev@collabora.com>
X-Headers-End: 1rrrXK-0006Kj-Qs
Subject: Re: [f2fs-dev] [PATCH v15 4/9] ext4: Reuse generic_ci_match for ci
 comparisons
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
Cc: krisman@suse.de, brauner@kernel.org, kernel@collabora.com, tytso@mit.edu,
 jack@suse.cz, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, adilger.kernel@dilger.ca,
 viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org,
 linux-ext4@vger.kernel.org, Gabriel Krisman Bertazi <krisman@collabora.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Apr 02, 2024 at 06:48:37PM +0300, Eugen Hristev wrote:
> +		ret = generic_ci_match(parent, fname->usr_fname,
> +				       &fname->cf_name, de->name,
> +				       de->name_len);
> +		if (ret < 0) {
> +			/*
> +			 * Treat comparison errors as not a match.  The
> +			 * only case where it happens is on a disk
> +			 * corruption or ENOMEM.
> +			 */
> +			return false;
>  		}
> -		return !ext4_ci_compare(parent, fname->usr_fname, de->name,
> -						de->name_len, false);
> +		return ret;

Maybe write this as simply 'return ret > 0;'?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
