Return-Path: <SRS0=41bR=VE=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38A6C48BDB
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  7 Jul 2019 20:43:33 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF95220656;
	Sun,  7 Jul 2019 20:43:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="N6G1rZTS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="WKOcU+GZ";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VEynfwpc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF95220656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hkE0D-00061U-UO; Sun, 07 Jul 2019 20:43:17 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <darrick.wong@oracle.com>) id 1hkE0C-00061F-Dr
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 07 Jul 2019 20:43:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6hBxH4XrKftdFNOpQ7bLkx+ErCc58NpfzAi14wvQyhY=; b=N6G1rZTSjCz6e8Nne6icofeVJ7
 Ld6N+VqvdGELkBj9olBehbUnMM2ZQvCI2lMhYtyLuOwnwZF3NfnP2hUFZ93t6t+VfGXh3gEelNn5N
 N3ERX3USB6eoXveB3pFyDIPM6SsgjBB8wLXlIgjiUo/tLpFwfOXSVqYE/lL0mlnC1uAQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6hBxH4XrKftdFNOpQ7bLkx+ErCc58NpfzAi14wvQyhY=; b=WKOcU+GZuFQelcoFF/4PPi4f42
 rCJZMz61H2lg4vGs/NtXIm5ZSkH3Pwv3cRmlscimS7WLmc45y7pAw1fHlAQqLI5sJz0LhcQz7THMP
 KKF/+tgFw84WAiTXN5jaZi5+/Hx0fZ3oXicAr/27XNPyLdgEMELjsKN7/lz9PUsDKpoU=;
Received: from userp2130.oracle.com ([156.151.31.86])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hkE0Q-00B3Nt-O5
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 07 Jul 2019 20:43:31 +0000
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x67KctMx027492;
 Sun, 7 Jul 2019 20:43:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2018-07-02;
 bh=6hBxH4XrKftdFNOpQ7bLkx+ErCc58NpfzAi14wvQyhY=;
 b=VEynfwpc7+wB4HF/DBjTgJbx/P2SauiSzAtBpAFVXI3bMoAnD/XvBp/CHOW72CUZyYMo
 oXnH9zM/UxK2qt5CJueeCRSl/BJ7zc6YoPv+QnNQ6rwFgeP33G5TKbjZRowpPrisw5Td
 41Dwg+qPaOAJuQbo4kPKOraddp2Nkqt1XUdIZRpy/p3nvN9wrprl7OBxMbgwSwFOfDyo
 BkaWujbckq0pOLnzgxFjJFjpBhNJ4lc5GgvUl/e00gWX+Sm7zcGP9n+J8ss7Sg9Nnp3a
 r0fy0HqrzxDx0maDR8qlMi38lwX8jS+rZ9SPsc6vnERgORUgUDHJCflPVUZ+nmmeo3eU MQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2tjk2tbaax-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 07 Jul 2019 20:43:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x67KcK2Z145282;
 Sun, 7 Jul 2019 20:41:22 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 2tjgrt7mh7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sun, 07 Jul 2019 20:41:22 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x67KfLjp018277;
 Sun, 7 Jul 2019 20:41:21 GMT
Received: from localhost (/67.169.218.210)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Sun, 07 Jul 2019 13:41:21 -0700
Date: Sun, 7 Jul 2019 13:41:17 -0700
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <20190707204117.GI1654093@magnolia>
References: <20190701202630.43776-1-ebiggers@kernel.org>
 <20190701202630.43776-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20190701202630.43776-2-ebiggers@kernel.org>
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
X-Headers-End: 1hkE0Q-00B3Nt-O5
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: use generic checking and prep
 function for FS_IOC_SETFLAGS
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

On Mon, Jul 01, 2019 at 01:26:28PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Make the f2fs implementation of FS_IOC_SETFLAGS use the new VFS helper
> function vfs_ioc_setflags_prepare().
> 
> This is based on a patch from Darrick Wong, but reworked to apply after
> commit 360985573b55 ("f2fs: separate f2fs i_flags from fs_flags and ext4
> i_flags").
> 
> Originally-from: Darrick J. Wong <darrick.wong@oracle.com>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

LGTM,
Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>

--D

> ---
>  fs/f2fs/file.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index e7c368db81851f..b5b941e6448657 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -1765,7 +1765,8 @@ static int f2fs_ioc_getflags(struct file *filp, unsigned long arg)
>  static int f2fs_ioc_setflags(struct file *filp, unsigned long arg)
>  {
>  	struct inode *inode = file_inode(filp);
> -	u32 fsflags;
> +	struct f2fs_inode_info *fi = F2FS_I(inode);
> +	u32 fsflags, old_fsflags;
>  	u32 iflags;
>  	int ret;
>  
> @@ -1789,8 +1790,14 @@ static int f2fs_ioc_setflags(struct file *filp, unsigned long arg)
>  
>  	inode_lock(inode);
>  
> +	old_fsflags = f2fs_iflags_to_fsflags(fi->i_flags);
> +	ret = vfs_ioc_setflags_prepare(inode, old_fsflags, fsflags);
> +	if (ret)
> +		goto out;
> +
>  	ret = f2fs_setflags_common(inode, iflags,
>  			f2fs_fsflags_to_iflags(F2FS_SETTABLE_FS_FL));
> +out:
>  	inode_unlock(inode);
>  	mnt_drop_write_file(filp);
>  	return ret;
> -- 
> 2.22.0.410.gd8fdbe21b5-goog
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
