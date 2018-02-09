From: Chao Yu <chao@kernel.org>
Subject: Re: [RFC PATCH 4/5] mkfs.f2fs: create lost+found
 directory
Date: Fri, 9 Feb 2018 21:13:56 +0800
Message-ID: <413ec5fe-ace6-db96-ea92-abf21a3ab4bb@kernel.org>
References: <20180206043125.134191-1-shengyong1@huawei.com>
 <20180206043125.134191-5-shengyong1@huawei.com>
 <dfbb59fc-d2c7-09d6-960c-8f3fc8163081@kernel.org>
 <9eb99d32-5e33-d7ad-d8f6-a1ad3d721086@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <chao@kernel.org>) id 1ek8VN-0002T3-2N
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Feb 2018 13:14:17 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ek8VM-0008TP-Ad
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Feb 2018 13:14:17 +0000
In-Reply-To: <9eb99d32-5e33-d7ad-d8f6-a1ad3d721086@huawei.com>
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
To: Sheng Yong <shengyong1@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: heyunlei@huawei.com, miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Hi Sheng Yong,

On 2018/2/9 11:21, Sheng Yong wrote:
> Hi, Chao
> 
> On 2018/2/8 23:08, Chao Yu wrote:
>> On 2018/2/6 12:31, Sheng Yong wrote:
>>> This patch introduces a new feature F2FS_FEATURE_LOST_FOUND. It can be
>>> switched on by indicating a new option `lost+found' with -O. If
>>
>> Not sure, do we need to change this option to 'lost_found' to follow other
>> generic -O options?
> 
> I'm also not sure about this, since there is already a `lost_found' in fsck :(

Change 'lost_found' to 'lost+found' in fsck to unify the output path?

>> Do not need to update this whole slot?
> 
> What do you mean by updating the whole slot? Two slots used by "lost+found"
> are filled.

'lost+found' takes two slots, but we need only fill all contents in first slot
and filename & bitmap of these two slots, as in both kernel/userspace sides,
we will skip updating & travelling second and later slots during add_link & lookup.
Let's keep consistent with the behavior.

Thanks,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
