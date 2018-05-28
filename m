From: Chao Yu <chao@kernel.org>
Subject: Re: disable loading f2fs module on PAGE_SIZE > 4KB
Date: Mon, 28 May 2018 19:01:56 +0800
Message-ID: <a8ce4029-620a-26a5-4147-49c31a4e300b@kernel.org>
References: <CADxRZqy-fgty4j74DhJ1dS1M9m50hdj_yBkc2KBdHF4xW4qqPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1fNFuq-0000MA-FN
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 May 2018 11:02:16 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fNFuk-004tu0-El
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 28 May 2018 11:02:16 +0000
In-Reply-To: <CADxRZqy-fgty4j74DhJ1dS1M9m50hdj_yBkc2KBdHF4xW4qqPg@mail.gmail.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Anatoly Pugachev <matorola@gmail.com>, Chao Yu <yuchao0@huawei.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

On 2018/5/28 7:06, Anatoly Pugachev wrote:
> Thanks for your comments.
> 
> The following patch disables loading of f2fs module on architectures
> which have PAGE_SIZE > 4096 , since it is impossible to mount f2fs on
> such architectures , log messages are:
> 
> # mount -t f2fs /dev/vdiskb1 /mnt
> mount: /mnt: wrong fs type, bad option, bad superblock on
> /dev/vdiskb1, missing codepage or helper program, or other error.
> # file -s /dev/vdiskb1
> /dev/vdiskb1: F2FS filesystem,
> UUID=1d8b9ca4-2389-4910-af3b-10998969f09c, volume name ""
> 
> May 15 18:03:13 ttip kernel: F2FS-fs (vdiskb1): Invalid
> page_cache_size (8192), supports only 4KB
> May 15 18:03:13 ttip kernel: F2FS-fs (vdiskb1): Can't find valid F2FS
> filesystem in 1th superblock
> May 15 18:03:13 ttip kernel: F2FS-fs (vdiskb1): Invalid
> page_cache_size (8192), supports only 4KB
> May 15 18:03:13 ttip kernel: F2FS-fs (vdiskb1): Can't find valid F2FS
> filesystem in 2th superblock
> May 15 18:03:13 ttip kernel: F2FS-fs (vdiskb1): Invalid
> page_cache_size (8192), supports only 4KB
> 
> which was introduced by git commit 5c9b469295fb6b10d98923eab5e79c4edb80ed20
> 
> tested on git kernel 4.17.0-rc6-00309-gec30dcf7f425
> 
> with patch applied:
> 
> # modprobe f2fs
> modprobe: ERROR: could not insert 'f2fs': Invalid argument
> # journalctl -e -k
> May 28 01:40:28 v215 kernel: F2FS not supported on PAGE_SIZE(8192) != 4096
> 
> v2 changes:
> - compare page size to f2fs BLKSIZE
> - print current page size on error
> 
> 
> Signed-off-by: Anatoly Pugachev <matorola@gmail.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
