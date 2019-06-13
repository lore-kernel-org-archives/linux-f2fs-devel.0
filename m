From: Chao Yu <yuchao0@huawei.com>
Subject: Re: =?utf-8?b?5Zue5aSNOiBbUEFUQ0ggMi8yXSBmMmZzOiBvbmx5?=
 =?utf-8?q?_set_project_inherit_bit_for_directory?=
Date: Thu, 13 Jun 2019 16:03:47 +0800
Message-ID: <110862e6-fd2a-b580-fec8-18a9b351ecb1@huawei.com>
References: <1559795545-17290-1-git-send-email-wshilong1991@gmail.com>
 <1559795545-17290-2-git-send-email-wshilong1991@gmail.com>
 <73fb9e88-d3f5-9420-d6d8-82ff4354e4d6@huawei.com>
 <MN2PR19MB3167496236BA4D366EAF5D36D4EF0@MN2PR19MB3167.namprd19.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hbKiG-0004s2-3f
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Jun 2019 08:04:00 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hbKiF-00BF9C-0u
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 13 Jun 2019 08:04:00 +0000
In-Reply-To: <MN2PR19MB3167496236BA4D366EAF5D36D4EF0@MN2PR19MB3167.namprd19.prod.outlook.com>
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
To: Wang Shilong <wshilong@ddn.com>, Wang Shilong <wangshilong1991@gmail.com>, "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>, "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>
Cc: Andreas Dilger <adilger@dilger.ca>

On 2019/6/13 15:34, Wang Shilong wrote:
> Hi Chao,
> 
>  I just sent a V2, but I think we'd better do that when reading inode, for two reasons:
> 
> 1) not only F2FS_IOC_GETFLAGS need filter flags but also F2FS_IOC_FSGETXATTR need that, so the amended parts is not enough IMO.
> 
> 2) doing that by reading inode give a benefit that we could correct on disk flags for regular file next dirtying inode happen.

Hi Shilong, agreed, I'm okay with that change. :)

Thanks,
