Return-Path: <SRS0=41bR=VE=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D29FEC48BDE
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  7 Jul 2019 20:42:25 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C68F20656;
	Sun,  7 Jul 2019 20:42:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="bNvftzKG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Zp9U6hY2";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Yowvw0VF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C68F20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hkDz7-0005sD-OI; Sun, 07 Jul 2019 20:42:09 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <darrick.wong@oracle.com>) id 1hkDz7-0005rr-45
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 07 Jul 2019 20:42:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vt3SZN0JDPBw66J952W5nQUebjM9H7IKiLkEthot7Sw=; b=bNvftzKGAlQXb781L7tA6ue0Eq
 TNv94neHEz1Jw/e8s3dIfM1HAi5kvTHxgUjtPOfprbk3lwdpOC+U4sTmH3g+KvW1Te/UGuYFSsHQz
 wostzallVmz+ZPjdTHUTU9zxWn+d6bEgZP7xpDq0CKMVZKAcJL37jlqgOwyQ49k7DUt4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vt3SZN0JDPBw66J952W5nQUebjM9H7IKiLkEthot7Sw=; b=Zp9U6hY27WbXh7ty+h/OofCLna
 2LYZGvSfwTMhvzEHgUcR/dHeWJh8W3D+HFB3QMFNr6aaZ79vfyhe1se37tvnHptTX8xgiTuAkty4H
 KvdyRsLIjjixg1RcCEk3+nq45bpCLuy3juHG1Zo5QLFvlRGNijWHK4+TTZqoRwXdENFs=;
Received: from aserp2120.oracle.com ([141.146.126.78])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hkDzK-00B3Lh-H8
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 07 Jul 2019 20:42:24 +0000
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x67KeNVd130079;
 Sun, 7 Jul 2019 20:42:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=vt3SZN0JDPBw66J952W5nQUebjM9H7IKiLkEthot7Sw=;
 b=Yowvw0VF7qQgpfBbpDM2wryc5/KQ4X/YB795dezEQmJVMfI1vdfFefcNIDibdySm5ZNQ
 /W2uanb4Vkar81azWEO+uP6Mb4+ZK2y73apVhxVmEwbRjgNqqS9zFIqbmSAnsO1TitlV
 E8CHRB2ecv2eycf8/AoIuwh07CxOYa2Jzhm5kQe8r6/Xy/sndRClfyWjBQ8rVqHxMKUj
 BmCEIGZCoHRnDwfR2x9fbKDYpYUjDgN7htFgBcv8K9tfGMkWV+aOQnGemIYw4zAIzHEo
 haNK7IF5KPE5ZsHbWQzKHRSduxLLMIz2TszE00fux5PwW/IC9F39Zy4/VyxYYWDKH+zG bg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 2tjkkpb93f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 07 Jul 2019 20:42:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x67KcJjD073681;
 Sun, 7 Jul 2019 20:42:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 2tjhpc70r2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 07 Jul 2019 20:42:14 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x67KgD3n007412;
 Sun, 7 Jul 2019 20:42:13 GMT
Received: from localhost (/67.169.218.210)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sun, 07 Jul 2019 13:42:13 -0700
Date: Sun, 7 Jul 2019 13:42:09 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20190707204209.GK1654093@magnolia>
References: <20190701202630.43776-1-ebiggers@kernel.org>
 <20190701202630.43776-4-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190701202630.43776-4-ebiggers@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9311
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907070289
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9311
 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907070289
X-Headers-End: 1hkDzK-00B3Lh-H8
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: remove redundant check from
 f2fs_setflags_common()
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
Cc: linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jul 01, 2019 at 01:26:30PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Now that f2fs_ioc_setflags() and f2fs_ioc_fssetxattr() call the VFS
> helper functions which check for permission to change the immutable and
> append-only flags, it's no longer needed to do this check in
> f2fs_setflags_common() too.  So remove it.
> 
> This is based on a patch from Darrick Wong, but reworked to apply after
> commit 360985573b55 ("f2fs: separate f2fs i_flags from fs_flags and ext4
> i_flags").
> 
> Originally-from: Darrick J. Wong <darrick.wong@oracle.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks ok,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/f2fs/file.c | 9 +--------
>  1 file changed, 1 insertion(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index ae1a54ecc9fccc..e8b81f6f5c2b15 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1648,19 +1648,12 @@ static int f2fs_file_flush(struct file *file, fl_owner_t id)
>  static int f2fs_setflags_common(struct inode *inode, u32 iflags, u32 mask)
>  {
>  	struct f2fs_inode_info *fi = F2FS_I(inode);
> -	u32 oldflags;
>  
>  	/* Is it quota file? Do not allow user to mess with it */
>  	if (IS_NOQUOTA(inode))
>  		return -EPERM;
>  
> -	oldflags = fi->i_flags;
> -
> -	if ((iflags ^ oldflags) & (F2FS_APPEND_FL | F2FS_IMMUTABLE_FL))
> -		if (!capable(CAP_LINUX_IMMUTABLE))
> -			return -EPERM;
> -
> -	fi->i_flags = iflags | (oldflags & ~mask);
> +	fi->i_flags = iflags | (fi->i_flags & ~mask);
>  
>  	if (fi->i_flags & F2FS_PROJINHERIT_FL)
>  		set_inode_flag(inode, FI_PROJ_INHERIT);
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
