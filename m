From: Daniel Rosenberg <drosen@google.com>
Subject: Re: [PATCH v3] f2fs: checkpoint disabling
Date: Fri, 10 Aug 2018 19:50:28 -0700
Message-ID: <8fa37886-7eef-edca-ea14-9d3465efaeac@google.com>
References: <20180807234843.129387-1-drosen@google.com>
 <b156678d-56e6-a46b-c7a6-00f4bc2c4b3d@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <b156678d-56e6-a46b-c7a6-00f4bc2c4b3d@huawei.com>
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>, Jonathan Corbet <corbet@lwn.net>, linux-f2fs-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@android.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 08/10/2018 01:40 AM, Chao Yu wrote:
> Hi Daniel,
>
> When filesystem is full, statfs shown abnormally as below:
>
> /dev/zram0       2095104 -17177769548 17179864652    - /mnt/f2fs
>
> I guess it's related to this patch, could you have a look at this?
>
> Thanks,
>
Thanks. It looks like I failed to check if we're running with 
checkpoints disabled inside of update_sit_entry when I updated the 
stats, causing it to underflow. I'll fix that in the next version.
